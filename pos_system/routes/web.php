<?php

use Illuminate\Support\Facades\Route;
use App\Models\Role;
// Controllerləri burada import edirik
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\StockController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\ProductDiscountController;
use App\Http\Controllers\CashRegisterController;
use App\Http\Controllers\PosController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ReturnController;
use App\Http\Controllers\StoreSettingController;
use App\Http\Controllers\ReceiptSettingController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// 1. Ana Səhifə (Dashboard)
Route::get('/', function () {
    return view('dashboard');
})->name('dashboard');

// 2. Rollar Səhifəsi
Route::get('/roles', function () {
    $roles = Role::all();
    return view('admin.roles.index', compact('roles'));
})->name('roles.index');

// 3. MƏHSULLAR VƏ KATEQORİYALAR
// ---------------------------------------------------------

// Barkod səhifəsi
Route::get('/products/print/barcodes', [ProductController::class, 'barcodes'])->name('products.barcodes');

// Mağaza Endirimləri (Real Controller ilə)
Route::get('/products/discounts', [ProductDiscountController::class, 'index'])->name('products.discounts');
Route::post('/products/discounts', [ProductDiscountController::class, 'store'])->name('discounts.store');
Route::post('/products/discounts/{discount}/stop', [ProductDiscountController::class, 'stop'])->name('discounts.stop');

// Kritik Limit Yeniləmə (Mağaza stokundan)
Route::post('/products/{product}/alert', [StockController::class, 'updateAlert'])->name('products.update_alert');

// İndi Resource-ları elan edirik
Route::resource('products', ProductController::class);
Route::resource('categories', CategoryController::class);


// 4. STOK VƏ ANBAR SİSTEMİ
// ---------------------------------------------------------

// Ümumi Stok (İcmal)
Route::get('/stocks', [StockController::class, 'index'])->name('stocks.index');

// Mal Qəbulu Forması
Route::get('/stocks/create', [StockController::class, 'create'])->name('stocks.create');

// Malı Yadda Saxla (POST) - Formadakı action bura gəlir
Route::post('/stocks', [StockController::class, 'storeData'])->name('stocks.store');

// Anbar Stoku (Partiyalar/FIFO)
Route::get('/stocks/warehouse', [StockController::class, 'warehouse'])->name('stocks.warehouse');

// Mağaza Stoku (Rəf)
Route::get('/stocks/market', [StockController::class, 'store'])->name('stocks.market');

// Transfer Sistemi
Route::get('/stocks/transfer', [StockController::class, 'transfer'])->name('stocks.transfer');
Route::post('/stocks/transfer', [StockController::class, 'processTransfer'])->name('stocks.transfer.process');

// Partiya Redaktə və Silmə
Route::get('/stocks/{batch}/edit', [StockController::class, 'edit'])->name('stocks.edit');
Route::put('/stocks/{batch}', [StockController::class, 'update'])->name('stocks.update');
Route::delete('/stocks/{batch}', [StockController::class, 'destroy'])->name('stocks.destroy');

// Təchizatçılar (v3)
Route::get('/suppliers', function () { return "Təchizatçılar Səhifəsi (v3)"; })->name('suppliers.index');


// 5. SATIŞ VƏ DİGƏR BÖLMƏLƏR
// ---------------------------------------------------------

// Kassa (POS) Sistem
Route::get('/pos', [PosController::class, 'index'])->name('pos.index');
Route::get('/pos/search', [PosController::class, 'search'])->name('pos.search');
Route::post('/pos/checkout', [PosController::class, 'store'])->name('pos.store');

// Satış Tarixçəsi
Route::get('/sales', [OrderController::class, 'index'])->name('sales.index');
Route::get('/sales/{order}', [OrderController::class, 'show'])->name('sales.show');
Route::get('/sales/{order}/print-official', [OrderController::class, 'printOfficial'])->name('sales.print_official');

// Qaytarma (Returns)
Route::get('/returns', [ReturnController::class, 'index'])->name('returns.index');
Route::get('/returns/search', [ReturnController::class, 'search'])->name('returns.search');
Route::post('/returns/{order}', [ReturnController::class, 'store'])->name('returns.store');

// Digər Placeholder-lər
Route::get('/lotteries', function () { return "Lotoreya Sistemi"; })->name('lotteries.index');
Route::get('/discounts', function () { return "Kampaniyalar (Ümumi)"; })->name('discounts.index');
Route::get('/promocodes', function () { return "Promokodlar"; })->name('promocodes.index');
Route::get('/partners', function () { return "Partnyorlar"; })->name('partners.index');
Route::get('/reports', function () { return "Hesabatlar Paneli"; })->name('reports.index');


// 6. TƏNZİMLƏMƏLƏR
// ---------------------------------------------------------

// Mağaza Məlumatları (Store Settings)
Route::get('/settings/store', [StoreSettingController::class, 'index'])->name('settings.store');
Route::post('/settings/store', [StoreSettingController::class, 'update'])->name('settings.store.update');

// Kassalar (Registers)
Route::get('/settings/registers', [CashRegisterController::class, 'index'])->name('settings.registers');
Route::post('/settings/registers', [CashRegisterController::class, 'store'])->name('registers.store');
Route::post('/settings/registers/{register}/toggle', [CashRegisterController::class, 'toggle'])->name('registers.toggle');
Route::delete('/settings/registers/{register}', [CashRegisterController::class, 'destroy'])->name('registers.destroy');

// Vergi Tənzimləmələri (Taxes)
Route::get('/settings/taxes', [TaxController::class, 'index'])->name('settings.taxes');
Route::post('/settings/taxes', [TaxController::class, 'store'])->name('taxes.store');
Route::post('/settings/taxes/{tax}/toggle', [TaxController::class, 'toggle'])->name('taxes.toggle');
Route::delete('/settings/taxes/{tax}', [TaxController::class, 'destroy'])->name('taxes.destroy');

// Qəbz Şablonu (Receipt Settings)
Route::get('/settings/receipt', [ReceiptSettingController::class, 'index'])->name('settings.receipt');
Route::post('/settings/receipt', [ReceiptSettingController::class, 'update'])->name('settings.receipt.update');

// Digər Ayarlar
Route::get('/settings/payments', function () { return "Ödəniş Növləri"; })->name('settings.payments');

// API Tənzimləmələri
Route::get('/settings/api', function() { return "API Tənzimləmələri Səhifəsi"; })->name('settings.api');


// 7. SİSTEM (YENİLƏMƏLƏR & BACKUP)
// ---------------------------------------------------------
// Backup və Restore
Route::get('/system/backup', function() { return "Backup və Restore Səhifəsi"; })->name('system.backup');

// Sistem Yeniləmələri
Route::get('/system/updates', function() { return "Sistem Yeniləmələri"; })->name('system.updates');

// Dillər və Tərcümə (v3)
Route::get('/system/languages', function() { return "Dillər və Tərcümə (v3)"; })->name('system.languages');
