<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductBatch;
use App\Models\Tax;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockController extends Controller
{
    // ... (Əvvəlki metodlar qalır: index, warehouse, store, create, storeData) ...
    public function index()
    {
        $products = Product::with(['category', 'batches' => function($query) {
            $query->where('current_quantity', '>', 0);
        }])->orderBy('name')->paginate(20);
        return view('admin.stocks.index', compact('products'));
    }

    public function warehouse()
    {
        $batches = ProductBatch::with('product')
                    ->where('current_quantity', '>', 0)
                    ->where('batch_code', 'like', '%LOC:warehouse%')
                    ->latest()->paginate(20);
        return view('admin.stocks.warehouse', compact('batches'));
    }

    public function store()
    {
        $products = Product::with(['category', 'batches' => function($query) {
            $query->where('batch_code', 'like', '%LOC:store%')->where('current_quantity', '>', 0);
        }])->orderBy('name')->paginate(20);
        return view('admin.stocks.store', compact('products'));
    }

    public function create()
    {
        $products = Product::select('id', 'name', 'barcode', 'selling_price')->orderBy('name')->get();
        $taxes = Tax::where('is_active', true)->get();
        return view('admin.stocks.create', compact('products', 'taxes'));
    }

    public function storeData(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'batches' => 'required|array|min:1',
            'batches.*.variant' => 'nullable|string',
            'batches.*.cost_price' => 'required|numeric|min:0',
            'batches.*.quantity' => 'required|integer|min:1',
            'batches.*.location' => 'required|in:warehouse,store',
        ]);

        DB::transaction(function () use ($request) {
            foreach ($request->batches as $batchData) {
                $code = ($batchData['variant'] ?? 'Standart') . ' | LOC:' . $batchData['location'];
                ProductBatch::create([
                    'product_id' => $request->product_id,
                    'cost_price' => $batchData['cost_price'],
                    'initial_quantity' => $batchData['quantity'],
                    'current_quantity' => $batchData['quantity'],
                    'batch_code' => $code,
                    'expiration_date' => null,
                ]);
            }
        });
        return redirect()->route('stocks.index')->with('success', 'Partiyalar uğurla qeydiyyata alındı!');
    }

    // --- YENİ: TRANSFER SİSTEMİ ---

    // Transfer Səhifəsi
    public function transfer()
    {
        // Anbarda stoku olan məhsulları və onların partiyalarını gətiririk
        $products = Product::whereHas('batches', function($query) {
            $query->where('batch_code', 'like', '%LOC:warehouse%')
                  ->where('current_quantity', '>', 0);
        })->with(['batches' => function($query) {
            // Məhsulun YALNIZ anbar partiyalarını gətiririk
            $query->where('batch_code', 'like', '%LOC:warehouse%')
                  ->where('current_quantity', '>', 0);
        }])->orderBy('name')->get();

        return view('admin.stocks.transfer', compact('products'));
    }

    // Transferi İcra Etmək
    public function processTransfer(Request $request)
    {
        $request->validate([
            'batch_id' => 'required|exists:product_batches,id',
            'quantity' => 'required|integer|min:1',
        ]);

        DB::transaction(function () use ($request) {
            // Anbardakı partiyanı tapırıq
            $warehouseBatch = ProductBatch::lockForUpdate()->findOrFail($request->batch_id);

            // Say yoxlanışı
            if ($warehouseBatch->current_quantity < $request->quantity) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'quantity' => 'Anbarda kifayət qədər məhsul yoxdur. Maksimum: ' . $warehouseBatch->current_quantity
                ]);
            }

            // 1. Anbardan azalt
            $warehouseBatch->decrement('current_quantity', $request->quantity);

            // 2. Mağazaya artır (Yeni partiya yaradaraq və ya mövcudun üstünə gələrək)
            // Kodun "LOC:warehouse" hissəsini "LOC:store" ilə əvəzləyirik
            $storeBatchCode = str_replace('LOC:warehouse', 'LOC:store', $warehouseBatch->batch_code);

            // Mağazada eyni qiymətli və eyni kodlu partiya varmı?
            $storeBatch = ProductBatch::where('product_id', $warehouseBatch->product_id)
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
                ]);
            }
        });

        return redirect()->route('stocks.market')->with('success', 'Transfer uğurla tamamlandı! Məhsul mağazaya köçürüldü.');
    }

    public function edit(ProductBatch $batch)
    {
        $taxes = Tax::where('is_active', true)->get();
        return view('admin.stocks.edit', compact('batch', 'taxes'));
    }

    public function update(Request $request, ProductBatch $batch)
    {
        $request->validate([
            'variant' => 'required|string',
            'location' => 'required|in:warehouse,store',
            'cost_price' => 'required|numeric|min:0',
            'quantity' => 'required|integer|min:0',
            'expiration_date' => 'nullable|date',
        ]);
        $code = $request->variant . ' | LOC:' . $request->location;
        $batch->update([
            'cost_price' => $request->cost_price,
            'current_quantity' => $request->quantity,
            'batch_code' => $code,
            'expiration_date' => $request->expiration_date,
        ]);
        return redirect()->route('stocks.warehouse')->with('success', 'Partiya məlumatları yeniləndi!');
    }

    public function destroy(ProductBatch $batch)
    {
        $batch->delete();
        return redirect()->route('stocks.warehouse')->with('success', 'Partiya silindi.');
    }

    public function updateAlert(Request $request, Product $product)
    {
        $request->validate(['alert_limit' => 'required|integer|min:0']);
        $product->update(['alert_limit' => $request->alert_limit]);
        return back()->with('success', 'Kritik limit yeniləndi.');
    }
}
