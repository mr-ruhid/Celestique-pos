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
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class PosController extends Controller
{
    // 1. POS Ekranını açır
    public function index()
    {
        // Kateqoriyalar və Məhsulları POS üçün yükləyirik
        // Mağaza stoku > 0 olanları gətiririk
        $products = Product::where('is_active', true)
            ->with(['activeDiscount', 'batches' => function($q) {
                // location sütunu mütləq olmalıdır (miqrasiya edilibsə)
                $q->where('location', 'store')->where('current_quantity', '>', 0);
            }])
            ->latest()
            ->get()
            ->map(function($product) {
                $product->store_stock = $product->batches->sum('current_quantity');
                return $product;
            });

        return view('admin.pos.index', compact('products'));
    }

    // 2. Məhsul Axtarışı (AJAX)
    public function search(Request $request)
    {
        $query = $request->get('q') ?? $request->get('query');

        if (!$query) {
            return response()->json([]);
        }

        $products = Product::with(['category', 'activeDiscount', 'batches' => function($q) {
                $q->where('location', 'store')->where('current_quantity', '>', 0);
            }])
            ->where('is_active', true)
            ->where(function($q) use ($query) {
                $q->where('name', 'like', "%{$query}%")
                  ->orWhere('barcode', 'like', "%{$query}%");
            })
            ->take(10)
            ->get();

        $results = $products->map(function($product) {
            // Yalnız mağaza stoku
            $stock = $product->batches->sum('current_quantity');

            $price = $product->selling_price;
            $discountAmount = 0;

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
                'tax_rate' => (float) $product->tax_rate,
                'stock' => (int) $stock
            ];
        });

        return response()->json($results);
    }

    // 3. Satışı Tamamla (Checkout)
    public function store(Request $request)
    {
        $request->validate([
            'cart' => 'required|array|min:1',
            'payment_method' => 'required|in:cash,card',
            'paid_amount' => 'required|numeric|min:0',
        ]);

        try {
            DB::beginTransaction();

            $totalCost = 0;
            $subtotal = 0;
            $totalTax = 0;
            $totalDiscount = 0;
            $grandTotal = 0;

            // --- İSTİFADƏÇİ XƏTASININ HƏLLİ ---
            // 1. Giriş etmiş istifadəçini yoxla
            $userId = Auth::id();

            // 2. Yoxdursa, bazadakı ilk istifadəçini götür
            if (!$userId) {
                $firstUser = User::first();
                if ($firstUser) {
                    $userId = $firstUser->id;
                } else {
                    // 3. Baza boşdursa, Avtomatik "Admin" istifadəçisi yarat
                    // Bu hissə "Attempt to read property 'id' on null" xətasını həll edir
                    $newUser = User::create([
                        'name' => 'Admin',
                        'email' => 'admin@system.local', // Dummy email
                        'password' => Hash::make('admin123'), // Dummy şifrə
                        // 'role' => 'admin' // Əgər role sütunu varsa, aktivləşdirin
                    ]);
                    $userId = $newUser->id;
                }
            }

            // Lotoreya kodunu modeldəki statik funksiya ilə yaradırıq (əgər varsa)
            $lotteryCode = method_exists(Order::class, 'generateUniqueLotteryCode')
                            ? Order::generateUniqueLotteryCode()
                            : (string) rand(1000, 9999);

            $order = Order::create([
                'user_id' => $userId,
                'receipt_code' => strtoupper(Str::random(8)),
                'lottery_code' => $lotteryCode,
                'subtotal' => 0,
                'total_discount' => 0,
                'total_tax' => 0,
                'grand_total' => 0,
                'total_cost' => 0,
                'paid_amount' => $request->paid_amount ?? $request->received_amount,
                'payment_method' => $request->payment_method,
                'status' => 'completed'
            ]);

            foreach ($request->cart as $item) {
                // lockForUpdate ilə məhsulu kilidləyirik
                $product = Product::lockForUpdate()->findOrFail($item['id']);
                $qtyNeeded = $item['qty'];

                // Hədiyyə olub-olmadığını yoxlayırıq
                $isGift = isset($item['is_gift']) && $item['is_gift'] == true;

                // --- MAĞAZA STOKUNDAN SİLMƏ (FIFO) ---
                $deductionResult = $this->deductFromStoreStock($product, $qtyNeeded);
                $productTotalCost = $deductionResult['total_cost'];

                // Maliyyə Hesablamaları
                $originalPrice = $product->selling_price;
                $discountAmount = 0;
                $taxAmount = 0;
                $lineTotal = 0;
                $currentTaxRate = $product->tax_rate ?? 0;

                // Potensial Vergi İtkisi
                $potentialTaxLoss = ($originalPrice * $currentTaxRate / 100) * $qtyNeeded;

                if ($isGift) {
                    // --- HƏDİYYƏ MƏNTİQİ ---
                    $price = 0;
                    $lineTotal = 0;
                    $discountAmount = 0;
                    $taxAmount = 0;

                    // Hesabat xərci: Maya + Vergi İtkisi
                    $itemCostForReport = $productTotalCost + $potentialTaxLoss;

                } else {
                    // --- NORMAL SATIŞ ---
                    $price = $originalPrice;

                    if ($product->activeDiscount) {
                        $d = $product->activeDiscount;
                        $discountAmount = ($d->type == 'fixed') ? $d->value : ($price * $d->value / 100);
                    }

                    // Vergi hesabı
                    $taxableAmount = ($price - $discountAmount) * $qtyNeeded;
                    $taxAmount = $taxableAmount * ($currentTaxRate / 100);

                    $lineTotal = ($price * $qtyNeeded) - ($discountAmount * $qtyNeeded) + $taxAmount;

                    // Normal satışda xərc = Maya Dəyəri
                    $itemCostForReport = $productTotalCost;
                }

                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'product_name' => $product->name,
                    'product_barcode' => $product->barcode,
                    'quantity' => $qtyNeeded,
                    'is_gift' => $isGift ?? false,
                    'price' => $price,
                    'cost' => ($qtyNeeded > 0) ? ($productTotalCost / $qtyNeeded) : 0,
                    'tax_amount' => $taxAmount,
                    'discount_amount' => $discountAmount * $qtyNeeded,
                    'total' => $lineTotal
                ]);

                // Ümumi Cəmlər
                $subtotal += ($price * $qtyNeeded);
                $totalDiscount += ($discountAmount * $qtyNeeded);
                $totalTax += $taxAmount;
                $grandTotal += $lineTotal;

                $totalCost += $itemCostForReport;
            }

            $paidAmount = $request->paid_amount ?? $request->received_amount;

            $order->update([
                'subtotal' => $subtotal,
                'total_discount' => $totalDiscount,
                'total_tax' => $totalTax,
                'grand_total' => $grandTotal,
                'total_cost' => $totalCost,
                'change_amount' => $paidAmount - $grandTotal
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Satış uğurla tamamlandı!',
                'order_id' => $order->id,
                'receipt_code' => $order->receipt_code,
                'lottery_code' => $order->lottery_code
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('POS Error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Xəta baş verdi: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Mağaza Stokundan Silmə Funksiyası (FIFO)
     */
    private function deductFromStoreStock($product, $qtyNeeded)
    {
        // 1. Yalnız MAĞAZA ('store') partiyalarını gətir
        $batches = ProductBatch::where('product_id', $product->id)
            ->where('location', 'store')
            ->where('current_quantity', '>', 0)
            ->orderBy('expiration_date', 'asc')
            ->orderBy('created_at', 'asc')
            ->lockForUpdate()
            ->get();

        $remainingQty = $qtyNeeded;
        $totalDeductedCost = 0;

        // Mağazada ümumi stok yoxlanışı
        $totalInStore = $batches->sum('current_quantity');

        if ($totalInStore < $qtyNeeded) {
            throw new \Exception("Mağazada '{$product->name}' məhsulundan kifayət qədər yoxdur! (Tələb: $qtyNeeded, Var: $totalInStore). Zəhmət olmasa Anbardan Transfer edin.");
        }

        foreach ($batches as $batch) {
            if ($remainingQty <= 0) break;

            $take = min($remainingQty, $batch->current_quantity);

            $totalDeductedCost += ($take * $batch->cost_price);

            $batch->decrement('current_quantity', $take);

            $remainingQty -= $take;
        }

        return ['total_cost' => $totalDeductedCost];
    }
}
