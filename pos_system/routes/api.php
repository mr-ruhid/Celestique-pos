<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\SyncController;
use App\Http\Controllers\Api\TelegramWebhookController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Mağaza (Lokal) tərəfi məlumatları buraya göndərəcək və ya buradan çəkəcək.
| Bütün sorğular API Key ilə qorunacaq.
|
*/

Route::prefix('v1')->group(function () {

    // --- SİNXRONİZASİYA (SYNC) ---

    // 1. Mağaza satışı bitirən kimi məlumatı bura göndərir (PUSH)
    Route::post('/sync/orders', [SyncController::class, 'storeOrders']);

    // 2. Mağaza yeni məhsulları və qiymətləri buradan çəkir (PULL)
    Route::get('/sync/products', [SyncController::class, 'getProducts']);

    // 3. Mağaza serverlə əlaqəni yoxlayır
    Route::get('/check-connection', function() {
        return response()->json(['status' => 'success', 'message' => 'Bağlantı uğurludur!']);
    });


    // --- TELEGRAM BOT WEBHOOK ---

    // Telegram-dan gələn mesajları (məs: /start) tutur
    // URL: https://sizin-sayt.com/api/v1/telegram/webhook
    Route::post('/telegram/webhook', [TelegramWebhookController::class, 'handle']);

});
