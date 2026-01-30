<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\ProductBatch;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class PosController extends Controller
{
    /**
     * POS (Kassa) ana ekranını yükləyir.
     */
    public function index()
    {
        return view('admin.pos.index');
    }

    /**
     * Məhsul axtarışı (Barkod oxuyucu və ya Ad ilə).
     * AJAX vasitəsilə işləyir.
     */
    public function search(Request $request)
    {
        $query = $request->get('query');

        if (!$query) {
            return response()->json([]);
        }

        // Aktiv məhsulları və onlara aid kateqoriya/endirim məlumatlarını gətiririk
        $products = Product::with(['category', 'activeDiscount'])
            ->where('is_active', true)
            ->where(function($q) use ($query) {
                $q->where('name', 'like', "%{$query}%")
                  ->orWhere('barcode', 'like', "%{$query}%");
            })
            ->take(10)
            ->get();

        // Məlumatları front-end (Alpine.js) üçün formatlayırıq
        $results = $products->map(function($product) {
            // Bütün partiyalar üzrə cəmi stok
            $stock = $product->batches->sum('current_quantity');

            $price = $product->selling_price;
            $discountAmount = 0;

            // Əgər məhsulun aktiv kampaniyası varsa endirimi hesablayırıq
            if ($product->activeDiscount) {
                $discount = $product->activeDiscount;
                if ($discount->type == 'fixed') {
                    $discountAmount = $discount->value;
                } else {
                    $discountAmount = ($price * $discount->value / 100);
                }
            }

            $finalPrice = $price - $discountAmount;

            return [
                'id' => $product->id,
                'name' => $product->name,
                'barcode' => $product->barcode,
                'image' => $product->image ? asset('storage/' . $product->image) : null,
                'price' => (float) $price,
                'discount_amount' => (float) $discountAmount,
                'final_price' => (float) $finalPrice,
                'tax_rate' => 0, // Vergi tənzimləmələrə görə 0 və ya dinamik ola bilər
                'stock' => (int) $stock
            ];
        });

        return response()->json($results);
    }

    /**
     * Satışı tamamlayır (Checkout).
     * Stokları azaldır, Order və OrderItem yaradır, Lotoreya kodu generasiya edir.
     */
    public function store(Request $request)
    {
        // Gələn məlumatların validasiyası
        $request->validate([
            'cart' => 'required|array|min:1',
            'payment_method' => 'required|in:cash,card',
            'paid_amount' => 'required|numeric|min:0',
            'promo_code' => 'nullable|string',
        ]);

        try {
            DB::beginTransaction();

            $totalCost = 0;
            $subtotal = 0;
            $totalTax = 0;
            $totalDiscount = 0;
            $grandTotal = 0;

            // XƏTA HƏLLİ: Əgər kassir daxil olmayıbsa (Auth::id null), bazadakı ilk useri (admin) götürürük
            $userId = Auth::id() ?? User::first()->id;

            // UNİKAL LOTOREYA KODU YARADILMASI (Məs: RJ-AB12-9876)
            $lotteryCode = 'RJ-' . strtoupper(Str::random(4)) . '-' . rand(1000, 9999);

            // 1. Order (Satış başlığı) yaradılır
            $order = Order::create([
                'user_id' => $userId,
                'receipt_code' => strtoupper(Str::random(8)),
                'lottery_code' => $lotteryCode,
                'subtotal' => 0, // Aşağıda hesablanıb update ediləcək
                'total_discount' => 0,
                'total_tax' => 0,
                'grand_total' => 0,
                'total_cost' => 0,
                'paid_amount' => $request->paid_amount,
                'payment_method' => $request->payment_method,
                'status' => 'completed'
            ]);

            // 2. Səbətdəki məhsulları dövr edirik və stokdan çıxarırıq (FIFO)
            foreach ($request->cart as $item) {
                $product = Product::lockForUpdate()->findOrFail($item['id']);
                $qtyNeeded = $item['qty'];
                $productTotalCost = 0;

                // --- FIFO STOK SİSTEMİ ---
                // Ən köhnə partiyadan başlayaraq stoku azaldırıq
                $batches = ProductBatch::where('product_id', $product->id)
                            ->where('current_quantity', '>', 0)
                            ->orderBy('created_at', 'asc')
                            ->lockForUpdate()
                            ->get();

                $remainingQty = $qtyNeeded;

                foreach ($batches as $batch) {
                    if ($remainingQty <= 0) break;

                    $take = min($remainingQty, $batch->current_quantity);
                    $batch->decrement('current_quantity', $take);

                    // Maya dəyərini hesablayırıq (Mənfəət analizi üçün)
                    $productTotalCost += ($take * $batch->cost_price);
                    $remainingQty -= $take;
                }

                // Satış qiyməti və Endirim yoxlanışı
                $price = $product->selling_price;
                $discountAmount = 0;

                if ($product->activeDiscount) {
                    $d = $product->activeDiscount;
                    $discountAmount = ($d->type == 'fixed') ? $d->value : ($price * $d->value / 100);
                }

                $taxAmount = 0; // Hazırda 0, ehtiyac olarsa tax_rate sütunundan hesablana bilər
                $lineTotal = ($price - $discountAmount + $taxAmount) * $qtyNeeded;

                // Satılan məhsulun detalları (OrderItem) yaradılır
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'product_name' => $product->name,
                    'product_barcode' => $product->barcode,
                    'quantity' => $qtyNeeded,
                    'price' => $price,
                    'cost' => ($qtyNeeded > 0) ? ($productTotalCost / $qtyNeeded) : 0, // Orta maya
                    'tax_amount' => $taxAmount * $qtyNeeded,
                    'discount_amount' => $discountAmount * $qtyNeeded,
                    'total' => $lineTotal
                ]);

                // Ümumi satış rəqəmlərini toplayırıq
                $subtotal += ($price * $qtyNeeded);
                $totalDiscount += ($discountAmount * $qtyNeeded);
                $totalTax += ($taxAmount * $qtyNeeded);
                $grandTotal += $lineTotal;
                $totalCost += $productTotalCost;
            }

            // 3. Order-i yekun hesablanmış məbləğlərlə yeniləyirik
            $order->update([
                'subtotal' => $subtotal,
                'total_discount' => $totalDiscount,
                'total_tax' => $totalTax,
                'grand_total' => $grandTotal,
                'total_cost' => $totalCost,
                'change_amount' => $request->paid_amount - $grandTotal // Qalıq (Sdat)
            ]);

            DB::commit();

            // Uğurlu cavab və çap üçün lazım olan məlumatlar geri göndərilir
            return response()->json([
                'success' => true,
                'message' => 'Satış uğurla tamamlandı!',
                'order_id' => $order->id,
                'receipt_code' => $order->receipt_code,
                'lottery_code' => $order->lottery_code
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Xəta baş verdi: ' . $e->getMessage()
            ], 500);
        }
    }
}
