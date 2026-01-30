<?php

namespace App\Services;

use App\Models\Order;
use App\Models\Product;
use App\Models\Category;
use App\Models\Setting;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class SyncService
{
    protected $serverUrl;
    protected $apiKey;

    public function __construct()
    {
        // Tənzimləmələrdən server məlumatlarını oxuyuruq
        $this->serverUrl = Setting::where('key', 'server_url')->value('value');
        $this->apiKey = Setting::where('key', 'client_api_key')->value('value');
    }

    /**
     * [CLIENT ROLU]
     * Satışları Serverə Göndərir (PUSH)
     */
    public function pushOrders()
    {
        // 1. Rejim yoxlanışı
        $mode = Setting::where('key', 'system_mode')->value('value');
        if ($mode !== 'client') {
            return ['status' => false, 'message' => 'Bu cihaz Mağaza (Client) rejimində deyil.'];
        }

        if (!$this->serverUrl || !$this->apiKey) {
            return ['status' => false, 'message' => 'Server URL və ya API Açar təyin edilməyib.'];
        }

        // 2. Göndərilməmiş satışları tapırıq
        // Sadəlik üçün hələlik son 20 satışı götürürük.
        // Server tərəfində ID yoxlanışı olduğu üçün təkrar yazılmayacaq.
        $orders = Order::with('items')
                       ->orderBy('created_at', 'desc')
                       ->take(20)
                       ->get();

        if ($orders->isEmpty()) {
            return ['status' => true, 'message' => 'Göndəriləcək satış yoxdur.'];
        }

        try {
            // 3. Serverə göndəririk
            $response = Http::withHeaders([
                'X-API-KEY' => $this->apiKey,
                'Accept' => 'application/json',
            ])->post($this->serverUrl . '/api/v1/sync/orders', [
                'orders' => $orders->toArray()
            ]);

            if ($response->successful()) {
                return ['status' => true, 'message' => 'Sinxronizasiya uğurlu: ' . $response->json()['message']];
            } else {
                Log::error('Sync Error: ' . $response->body());
                return ['status' => false, 'message' => 'Server xətası: ' . $response->status()];
            }

        } catch (\Exception $e) {
            Log::error('Sync Connection Error: ' . $e->getMessage());
            return ['status' => false, 'message' => 'Bağlantı xətası: ' . $e->getMessage()];
        }
    }

    /**
     * [CLIENT ROLU]
     * Məhsulları Serverdən Gətirir (PULL)
     */
    public function pullProducts()
    {
        $mode = Setting::where('key', 'system_mode')->value('value');
        if ($mode !== 'client') {
            return ['status' => false, 'message' => 'Bu cihaz Mağaza (Client) rejimində deyil.'];
        }

        try {
            $response = Http::withHeaders([
                'X-API-KEY' => $this->apiKey,
                'Accept' => 'application/json',
            ])->get($this->serverUrl . '/api/v1/sync/products');

            if ($response->successful()) {
                $productsData = $response->json()['products'];

                DB::beginTransaction();
                foreach ($productsData as $data) {
                    // Kateqoriyanı yoxla/yarat
                    if (isset($data['category'])) {
                        Category::firstOrCreate(
                            ['id' => $data['category']['id']],
                            ['name' => $data['category']['name'], 'slug' => $data['category']['slug']]
                        );
                    }

                    // Məhsulu yenilə və ya yarat
                    // DİQQƏT: Stok sayını serverdən götürmürük (Lokal stok vacibdir)
                    // Yalnız ad, qiymət və vergi yenilənir
                    Product::updateOrCreate(
                        ['id' => $data['id']], // UUID
                        [
                            'name' => $data['name'],
                            'barcode' => $data['barcode'],
                            'category_id' => $data['category_id'],
                            'selling_price' => $data['selling_price'],
                            'tax_rate' => $data['tax_rate'],
                            'is_active' => $data['is_active'],
                            'last_synced_at' => now()
                        ]
                    );
                }
                DB::commit();

                return ['status' => true, 'message' => count($productsData) . ' məhsul yeniləndi.'];
            } else {
                return ['status' => false, 'message' => 'Server xətası: ' . $response->status()];
            }

        } catch (\Exception $e) {
            DB::rollBack();
            return ['status' => false, 'message' => 'Bağlantı xətası: ' . $e->getMessage()];
        }
    }
}
