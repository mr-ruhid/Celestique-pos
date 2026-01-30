<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Product;
use App\Models\Setting;
use App\Services\SyncService;
use Illuminate\Http\Request;
use Carbon\Carbon;

class DashboardController extends Controller
{
    // Ana Səhifəni Yükləyir
    public function index()
    {
        $today = Carbon::today();

        $todaysOrders = Order::whereDate('created_at', $today)->get();
        $totalSalesToday = $todaysOrders->sum('grand_total');
        $totalOrdersToday = $todaysOrders->count();
        // Mənfəət = Satış - (Cost + Commission)
        $totalProfitToday = $todaysOrders->sum('grand_total') - ($todaysOrders->sum('total_cost') + $todaysOrders->sum('total_commission'));

        $lowStockProducts = Product::with('batches')
            ->where('is_active', true)
            ->get()
            ->filter(function ($product) {
                return $product->total_stock <= $product->alert_limit;
            })
            ->take(5);

        $recentOrders = Order::with('user')->latest()->take(5)->get();

        $systemMode = Setting::where('key', 'system_mode')->value('value') ?? 'standalone';

        return view('dashboard', compact(
            'totalSalesToday',
            'totalOrdersToday',
            'totalProfitToday',
            'lowStockProducts',
            'recentOrders',
            'systemMode'
        ));
    }

    // Manual və Avtomatik Sinxronizasiya (YENİLƏNDİ)
    public function syncNow(Request $request, SyncService $syncService)
    {
        // 1. Satışları Göndər (PUSH)
        $pushResult = $syncService->pushOrders();

        // 2. Məhsulları Gətir (PULL)
        $pullResult = $syncService->pullProducts();

        $message = "Göndərildi: {$pushResult['message']} | Qəbul edildi: {$pullResult['message']}";
        $status = $pushResult['status'] && $pullResult['status'];

        // Əgər sorğu AJAX-dırsa (Arxa planda işləyirsə), JSON qaytar
        if ($request->ajax()) {
            return response()->json([
                'success' => $status,
                'message' => $message
            ]);
        }

        // Əgər düyməyə basılıbsa, səhifəni yenilə
        if ($status) {
            return back()->with('success', "Sinxronizasiya Uğurlu!\n" . $message);
        } else {
            return back()->with('error', "Xəta: " . $message);
        }
    }
}
