<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ServerSetupController extends Controller
{
    public function index()
    {
        $settings = Setting::pluck('value', 'key')->toArray();

        // API Açar yoxdursa yarat
        if (!isset($settings['server_api_key'])) {
            $apiKey = 'rj_' . Str::random(40);
            Setting::updateOrCreate(['key' => 'server_api_key'], ['value' => $apiKey]);
            $settings['server_api_key'] = $apiKey;
        }

        return view('admin.settings.server', compact('settings'));
    }

    public function update(Request $request)
    {
        // Validasiya
        $request->validate([
            'system_mode' => 'required|in:standalone,server,client',
            // URL və API Key yalnız Client olduqda vacibdir, amma nullable qoyuruq ki xəta verməsin
            'server_url' => 'nullable|url',
            'client_api_key' => 'nullable|string',
        ]);

        // 1. Rejimi Yadda Saxla
        Setting::updateOrCreate(
            ['key' => 'system_mode'],
            ['value' => $request->system_mode]
        );

        // 2. Digər məlumatları (əgər gəlibsə) yadda saxla
        if ($request->has('server_url')) {
            Setting::updateOrCreate(['key' => 'server_url'], ['value' => $request->server_url]);
        }

        if ($request->has('client_api_key')) {
            Setting::updateOrCreate(['key' => 'client_api_key'], ['value' => $request->client_api_key]);
        }

        return back()->with('success', 'Sistem rejimi yeniləndi: ' . strtoupper($request->system_mode));
    }
}
