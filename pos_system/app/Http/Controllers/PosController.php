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
        $products = Product::where('is_active', true)
            ->with(['activeDiscount', 'batches' => function($q) {
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

    // 2. Məhsul Axtarışı
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
            $stock = $product->batches->sum('current_quantity');
            $price = (float) $product->selling_price;
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
                'price' => $price,
                'discount_amount' => (float) $discountAmount,
                'final_price' => (float) $finalPrice,
                'tax_rate' => (float) ($product->tax_rate ?? 0),
                'stock' => (int) $stock
            ];
        });

        return response()->json($results);
    }

    // 3. Satışı Tamamla
    public function store(Request $request)
    {
        $request->validate([
            'cart' => 'required|array|min:1',
            'payment_method' => 'required|in:cash,card,bonus',
            'paid_amount' => 'required|numeric|min:0',
        ]);

        try {
            DB::beginTransaction();

            $totalCost = 0;
            $subtotal = 0;
            $totalTax = 0;
            $totalDiscount = 0;
            $grandTotal = 0;

            // İstifadəçi təyini
            $userId = Auth::id();
            if (!$userId) {
                $firstUser = User::first();
                $userId = $firstUser ? $firstUser->id : User::create([
                    'name' => 'Admin',
                    'email' => 'admin@system.local',
                    'password' => Hash::make('admin123')
                ])->id;
            }

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
                $product = Product::lockForUpdate()->findOrFail($item['id']);
                $qtyNeeded = $item['qty'];

                // DÜZƏLİŞ: Hədiyyə dəyərinin düzgün oxunması (String "false" problemi həlli)
                $isGiftRaw = $item['is_gift'] ?? false;
                $isGift = filter_var($isGiftRaw, FILTER_VALIDATE_BOOLEAN);

                // Stokdan silmə
                $deductionResult = $this->deductFromStoreStock($product, $qtyNeeded);
                $productTotalCost = $deductionResult['total_cost'];

                // Qiymət və Vergi Parametrləri
                $originalPrice = (float) $product->selling_price;
                $currentTaxRate = (float) ($product->tax_rate ?? 0);

                $discountAmount = 0;
                $taxAmount = 0;
                $lineTotal = 0;

                if ($isGift) {
                    // Hədiyyə: Qiymət 0, Vergi 0
                    $price = 0;
                    $lineTotal = 0;

                    // Hesabatda Ziyan = Maya + Potensial Vergi (itki)
                    $potentialTaxLoss = ($originalPrice * $currentTaxRate / 100) * $qtyNeeded;
                    $itemCostForReport = $productTotalCost + $potentialTaxLoss;

                } else {
                    // Normal Satış
                    $price = $originalPrice;

                    // Endirim Hesabı
                    if ($product->activeDiscount) {
                        $d = $product->activeDiscount;
                        $discountAmount = ($d->type == 'fixed') ? $d->value : ($price * $d->value / 100);
                    }

                    // Yekun vahid qiyməti (Endirimli)
                    $finalUnitTestPrice = $price - $discountAmount;
                    $lineTotal = $finalUnitTestPrice * $qtyNeeded;

                    // --- VERGİ HESABLAMA (POS Məntiqi) ---
                    // Vergi qiymətə daxildir.
                    // Məsələn: 118 AZN (18% vergi) => Qiymət 100, Vergi 18.
                    if ($currentTaxRate > 0) {
                        $basePriceTotal = $lineTotal / (1 + ($currentTaxRate / 100));
                        $taxAmount = $lineTotal - $basePriceTotal;
                    } else {
                        $taxAmount = 0;
                    }

                    // Normal satışda xərc sadəcə maya dəyəridir
                    $itemCostForReport = $productTotalCost;
                }

                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'product_name' => $product->name,
                    'product_barcode' => $product->barcode,
                    'quantity' => $qtyNeeded,
                    'is_gift' => $isGift,
                    'price' => $price,
                    'cost' => ($qtyNeeded > 0) ? ($productTotalCost / $qtyNeeded) : 0,
                    'tax_amount' => $taxAmount, // Hesablanmış vergi
                    'discount_amount' => $discountAmount * $qtyNeeded,
                    'total' => $lineTotal
                ]);

                // Ümumi Cəmlər
                $subtotal += ($originalPrice * $qtyNeeded);
                $totalDiscount += ($discountAmount * $qtyNeeded);
                $totalTax += $taxAmount;
                $grandTotal += $lineTotal;

                $totalCost += $itemCostForReport;
            }

            $paidAmount = $request->paid_amount ?? $request->received_amount;

            $order->update([
                'subtotal' => $subtotal,
                'total_discount' => $totalDiscount,
                'total_tax' => $totalTax, // Vergi cəmi
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

    private function deductFromStoreStock($product, $qtyNeeded)
    {
        $batches = ProductBatch::where('product_id', $product->id)
            ->where('location', 'store')
            ->where('current_quantity', '>', 0)
            ->orderBy('expiration_date', 'asc')
            ->orderBy('created_at', 'asc')
            ->lockForUpdate()
            ->get();

        $remainingQty = $qtyNeeded;
        $totalDeductedCost = 0;

        $totalInStore = $batches->sum('current_quantity');

        if ($totalInStore < $qtyNeeded) {
            throw new \Exception("Mağazada '{$product->name}' məhsulundan kifayət qədər yoxdur! (Tələb: $qtyNeeded, Var: $totalInStore).");
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
