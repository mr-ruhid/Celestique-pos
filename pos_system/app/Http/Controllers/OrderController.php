<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Setting; // Tənzimləmələr modelini əlavə edirik
use Illuminate\Http\Request;

class OrderController extends Controller
{
    // Satış Tarixçəsi Siyahısı
    public function index()
    {
        // Satışları ən sondan əvvələ doğru gətiririk
        // 'user' əlaqəsi ilə kassiri, 'items' ilə məhsul sayını biləcəyik
        $orders = Order::with(['user', 'items'])->latest()->paginate(20);

        return view('admin.sales.index', compact('orders'));
    }

    // Satışın Detalları (Çek Görüntüsü)
    // DÜZƏLİŞ: Birbaşa Model Binding (Order $order) istifadə edirik
    public function show(Order $order)
    {
        // Əlaqəli məlumatları (Kassir və Məhsullar) yükləyirik
        $order->load(['user', 'items']);

        // Mağaza məlumatlarını (Ad, Ünvan, Telefon) bazadan çəkirik
        // "key => value" formatında array kimi alırıq ki, view-da rahat işlədək
        $settings = Setting::pluck('value', 'key')->toArray();

        return view('admin.sales.show', compact('order', 'settings'));
    }
}
