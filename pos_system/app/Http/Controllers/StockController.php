<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductBatch;
use App\Models\Tax;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockController extends Controller
{
    // 1. Ümumi Stok İcmalı
    public function index()
    {
        // Hesablamalar location sütununa görə aparılır
        $totalStock = ProductBatch::sum('current_quantity');
        $warehouseStock = ProductBatch::where('location', 'warehouse')->sum('current_quantity');
        $storeStock = ProductBatch::where('location', 'store')->sum('current_quantity');

        // Son hərəkətlər
        $recentBatches = ProductBatch::with('product')->latest()->take(10)->get();

        return view('admin.stocks.index', compact('totalStock', 'warehouseStock', 'storeStock', 'recentBatches'));
    }

    // 2. Anbar Stoku (Yalnız Anbarda olanlar)
    public function warehouse()
    {
        $batches = ProductBatch::with('product')
                    ->where('current_quantity', '>', 0)
                    ->where('location', 'warehouse') // Düzəliş: batch_code yox, location sütunu
                    ->latest()
                    ->paginate(20);

        return view('admin.stocks.warehouse', compact('batches'));
    }

    // 3. Mağaza Stoku (Yalnız Satışa Hazır olanlar)
    public function store()
    {
        $batches = ProductBatch::with('product')
                    ->where('current_quantity', '>', 0)
                    ->where('location', 'store') // Düzəliş: batch_code yox, location sütunu
                    ->latest()
                    ->paginate(20);

        return view('admin.stocks.market', compact('batches')); // View adı 'store' və ya 'market' ola bilər, sizin struktura uyğunlaşdırdım
    }

    // 4. Yeni Mal Qəbulu Forması
    public function create()
    {
        $products = Product::select('id', 'name', 'barcode', 'selling_price')->where('is_active', true)->orderBy('name')->get();
        $taxes = class_exists(Tax::class) ? Tax::where('is_active', true)->get() : [];
        return view('admin.stocks.create', compact('products', 'taxes'));
    }

    // 5. Malı Yadda Saxla (POST)
    // DÜZƏLİŞ: Yeni gələn mal MÜTLƏQ Anbara ('warehouse') düşür
    public function storeData(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'batches' => 'required|array|min:1',
            'batches.*.variant' => 'nullable|string',
            'batches.*.cost_price' => 'required|numeric|min:0',
            'batches.*.quantity' => 'required|integer|min:1',
            // 'location' inputunu tələb etmirik, çünki avtomatik 'warehouse' olacaq
        ]);

        DB::transaction(function () use ($request) {
            foreach ($request->batches as $batchData) {
                // Kodun vizual hissəsi üçün hələ də LOC:warehouse yaza bilərik
                $code = ($batchData['variant'] ?? 'Standart') . ' | LOC:warehouse';

                ProductBatch::create([
                    'product_id' => $request->product_id,
                    'cost_price' => $batchData['cost_price'],
                    'initial_quantity' => $batchData['quantity'],
                    'current_quantity' => $batchData['quantity'],
                    'batch_code' => $code,
                    'expiration_date' => null, // Əgər formda varsa əlavə edin: $batchData['expiration_date'] ?? null

                    // --- ƏN VACİB HİSSƏ ---
                    'location' => 'warehouse' // Məcburi Anbar statusu
                ]);
            }
        });

        return redirect()->route('stocks.index')->with('success', 'Partiyalar uğurla ANBARA qəbul edildi!');
    }

    // --- TRANSFER SİSTEMİ ---

    // 6. Transfer Səhifəsi
    public function transfer()
    {
        // Anbarda malı olan məhsulları gətirir
        $products = Product::whereHas('batches', function($query) {
            $query->where('location', 'warehouse')
                  ->where('current_quantity', '>', 0);
        })->with(['batches' => function($query) {
            // Məhsulun YALNIZ anbar partiyalarını gətiririk
            $query->where('location', 'warehouse')
                  ->where('current_quantity', '>', 0);
        }])->orderBy('name')->get();

        return view('admin.stocks.transfer', compact('products'));
    }

    // 7. Transferi İcra Et
    public function processTransfer(Request $request)
    {
        $request->validate([
            'batch_id' => 'required|exists:product_batches,id',
            'quantity' => 'required|integer|min:1',
        ]);

        DB::transaction(function () use ($request) {
            // Anbardakı partiyanı tapırıq
            $warehouseBatch = ProductBatch::lockForUpdate()->findOrFail($request->batch_id);

            // Bu partiyanın həqiqətən anbarda olduğunu yoxlayırıq
            if ($warehouseBatch->location !== 'warehouse') {
                 throw \Illuminate\Validation\ValidationException::withMessages([
                    'batch_id' => 'Seçilən partiya anbarda deyil.'
                ]);
            }

            // Say yoxlanışı
            if ($warehouseBatch->current_quantity < $request->quantity) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'quantity' => 'Anbarda kifayət qədər məhsul yoxdur. Maksimum: ' . $warehouseBatch->current_quantity
                ]);
            }

            // 1. Anbardan azalt
            $warehouseBatch->decrement('current_quantity', $request->quantity);

            // 2. Mağazaya artır
            // Kodun vizual hissəsini dəyişirik
            $storeBatchCode = str_replace('LOC:warehouse', 'LOC:store', $warehouseBatch->batch_code);

            // Əgər kodda LOC yoxdursa, əlavə edək
            if ($storeBatchCode === $warehouseBatch->batch_code) {
                $storeBatchCode = $warehouseBatch->batch_code . ' | LOC:store';
            }

            // Mağazada eyni qiymətli, eyni kodlu və eyni son istifadə tarixli partiya varmı?
            $storeBatch = ProductBatch::where('product_id', $warehouseBatch->product_id)
                            ->where('location', 'store') // <--- Hədəf Mağaza
                            ->where('batch_code', $storeBatchCode)
                            ->where('cost_price', $warehouseBatch->cost_price)
                            ->first();

            if ($storeBatch) {
                $storeBatch->increment('current_quantity', $request->quantity);
            } else {
                ProductBatch::create([
                    'product_id' => $warehouseBatch->product_id,
                    'cost_price' => $warehouseBatch->cost_price,
                    'initial_quantity' => $request->quantity,
                    'current_quantity' => $request->quantity,
                    'batch_code' => $storeBatchCode,
                    'expiration_date' => $warehouseBatch->expiration_date,
                    'location' => 'store' // <--- Yeni yaranan partiya Mağazada olur
                ]);
            }
        });

        return redirect()->route('stocks.market')->with('success', 'Transfer uğurla tamamlandı! Məhsul mağazaya köçürüldü.');
    }

    public function edit(ProductBatch $batch)
    {
        $taxes = class_exists(Tax::class) ? Tax::where('is_active', true)->get() : [];
        return view('admin.stocks.edit', compact('batch', 'taxes'));
    }

    public function update(Request $request, ProductBatch $batch)
    {
        $request->validate([
            'variant' => 'nullable|string',
            'location' => 'required|in:warehouse,store',
            'cost_price' => 'required|numeric|min:0',
            'quantity' => 'required|integer|min:0',
            'expiration_date' => 'nullable|date',
        ]);

        $variant = $request->variant ?? 'Standart';
        $code = $variant . ' | LOC:' . $request->location;

        $batch->update([
            'cost_price' => $request->cost_price,
            'current_quantity' => $request->quantity,
            'batch_code' => $code,
            'expiration_date' => $request->expiration_date,
            'location' => $request->location // Manual redaktə zamanı yeri dəyişmək olar
        ]);

        return redirect()->route('stocks.index')->with('success', 'Partiya məlumatları yeniləndi!');
    }

    public function destroy(ProductBatch $batch)
    {
        $batch->delete();
        return redirect()->route('stocks.index')->with('success', 'Partiya silindi.');
    }

    public function updateAlert(Request $request, Product $product)
    {
        $request->validate(['alert_limit' => 'required|integer|min:0']);
        $product->update(['alert_limit' => $request->alert_limit]);
        return back()->with('success', 'Kritik limit yeniləndi.');
    }
}
