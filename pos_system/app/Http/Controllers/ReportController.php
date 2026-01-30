<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\Product;
use App\Models\ProductBatch; // Stock əvəzinə
use App\Models\Partner;
use App\Models\Setting;
use App\Models\Promocode;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ReportController extends Controller
{
    /**
     * 1. HESABATLAR PANELİ (Dashboard)
     * Ümumi icmal
     */
    public function index()
    {
        // 1. Backup Məlumatı
        $backupFiles = Storage::files('backups');
        $backupCount = count(array_filter($backupFiles, fn($f) => str_ends_with($f, '.zip') || str_ends_with($f, '.sql')));
        $lastBackup = Setting::where('key', 'last_backup_date')->value('value');

        // 2. Bu günün satışı
        $todaySales = Order::whereDate('created_at', Carbon::today())->sum('grand_total');

        // 3. Ümumi Məhsul Sayı
        $totalProducts = Product::count();

        // 4. Kritik Stok Sayı (ProductBatch-dən hesablayırıq)
        // DÜZƏLİŞ: whereColumn subquery dəstəkləmədiyi üçün whereRaw istifadə edirik
        // Məntiq: Elə məhsulları say ki, onların 'alert_limit' dəyəri anbarda olan cəmi saydan böyük olsun.
        $criticalStockCount = Product::whereRaw('alert_limit > (select coalesce(sum(current_quantity), 0) from product_batches where product_batches.product_id = products.id)')->count();

        return view('admin.reports.index', compact('backupCount', 'lastBackup', 'todaySales', 'totalProducts', 'criticalStockCount'));
    }

    /**
     * 2. MƏNFƏƏT HESABATI (Detallı)
     * Düstur: (Satış - Endirim) - (Maya + Vergi)
     * Qeyd: Order modelində 'grand_total' artıq (subtotal - discount + tax) kimidir.
     * Təmiz Mənfəət = grand_total - total_tax - total_cost
     */
    public function profit(Request $request)
    {
        $startDate = $request->start_date ? Carbon::parse($request->start_date) : Carbon::now()->startOfMonth();
        $endDate = $request->end_date ? Carbon::parse($request->end_date)->endOfDay() : Carbon::now()->endOfDay();

        // Yalnız tamamlanmış satışları götürürük (status varsa)
        $orders = Order::whereBetween('created_at', [$startDate, $endDate])->get();

        // Hesablamalar
        $totalRevenue = $orders->sum('grand_total'); // Kassa giriş (Endirim çıxılıb, Vergi gəlib)
        $totalCost = $orders->sum('total_cost');     // Satılan malın mayası
        $totalTax = $orders->sum('total_tax');       // Dövlətə çatacaq vergi
        $totalDiscount = $orders->sum('total_discount'); // Cəmi endirimlər

        // Sizin düstura əsasən Təmiz Mənfəət:
        // (Satış - Maya - Vergi)
        // Qeyd: 'grand_total' daxilində vergi var, ona görə onu çıxırıq.
        $netProfit = $totalRevenue - $totalTax - $totalCost;

        return view('admin.reports.profit', compact(
            'startDate', 'endDate',
            'totalRevenue', 'totalCost', 'totalTax', 'totalDiscount', 'netProfit'
        ));
    }

    /**
     * 3. STOK HESABATI (ProductBatch əsasında)
     * Anbarda nə qədər mal var və dəyəri nədir?
     */
    public function stock()
    {
        // Ümumi Maya Dəyəri (Anbardakı malın mayası)
        $totalCostValue = ProductBatch::sum(DB::raw('current_quantity * cost_price'));

        // Ümumi Satış Dəyəri (Anbardakı malın satış qiyməti)
        // Bunu tapmaq üçün Product modelinə qoşulmalıyıq
        $totalSaleValue = ProductBatch::join('products', 'product_batches.product_id', '=', 'products.id')
            ->sum(DB::raw('product_batches.current_quantity * products.selling_price'));

        // Gözlənilən Mənfəət (Hamsı satılsa)
        $potentialProfit = $totalSaleValue - $totalCostValue;

        // Partiyalar siyahısı (Bitməyənlər)
        $batches = ProductBatch::with('product')
            ->where('current_quantity', '>', 0)
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return view('admin.reports.stock', compact('totalCostValue', 'totalSaleValue', 'potentialProfit', 'batches'));
    }

    /**
     * 4. PARTNYOR VƏ PROMOKOD HESABATI
     */
    public function partners()
    {
        // Partnyorlar və onların qazandırdığı satışlar
        $partners = Partner::with(['promocodes' => function($query) {
            $query->withCount('orders')
                  ->withSum('orders', 'grand_total'); // Hər promokodun gətirdiyi cəmi satış
        }])->get();

        // Ümumi Promokod Statistikası
        $promocodes = Promocode::withCount('orders')
            ->orderBy('orders_count', 'desc')
            ->get();

        return view('admin.reports.partners', compact('partners', 'promocodes'));
    }

    /**
     * 5. SATIŞ HESABATI (Ödəniş növləri ilə)
     */
    public function sales(Request $request)
    {
        $startDate = $request->start_date ? Carbon::parse($request->start_date) : Carbon::now()->startOfMonth();
        $endDate = $request->end_date ? Carbon::parse($request->end_date)->endOfDay() : Carbon::now()->endOfDay();

        $orders = Order::with('user')
            ->whereBetween('created_at', [$startDate, $endDate])
            ->latest()
            ->paginate(15);

        // Ödəniş növlərinə görə qruplaşdırma
        $paymentStats = Order::whereBetween('created_at', [$startDate, $endDate])
            ->select('payment_method', DB::raw('sum(grand_total) as total'), DB::raw('count(*) as count'))
            ->groupBy('payment_method')
            ->get();

        return view('admin.reports.sales', compact('orders', 'paymentStats', 'startDate', 'endDate'));
    }
}
