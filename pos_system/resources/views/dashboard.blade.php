@extends('layouts.admin')

@section('content')
    <!-- Səhifə Başlığı -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-semibold text-gray-800">İdarəetmə Paneli</h1>
        <div class="flex space-x-2">
            <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition duration-150 ease-in-out">
                <i class="fa-solid fa-plus mr-2"></i> Yeni Satış
            </button>
        </div>
    </div>

    <!-- Statistik Kartlar (Yuxarı hissə) -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">

        <!-- Kart 1: Günlük Satış -->
        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-green-500">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-medium text-gray-500 uppercase tracking-wider">Bugünkü Satış</p>
                    <h3 class="text-2xl font-bold text-gray-800 mt-1">1,250.00 ₼</h3>
                </div>
                <div class="p-2 bg-green-100 rounded-lg">
                    <i class="fa-solid fa-sack-dollar text-green-600 text-xl"></i>
                </div>
            </div>
            <p class="text-sm text-green-600 mt-4 flex items-center">
                <i class="fa-solid fa-arrow-trend-up mr-1"></i> +15% dünənə görə
            </p>
        </div>

        <!-- Kart 2: Satış Sayı (Orders) -->
        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-blue-500">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-medium text-gray-500 uppercase tracking-wider">Çek Sayı</p>
                    <h3 class="text-2xl font-bold text-gray-800 mt-1">45</h3>
                </div>
                <div class="p-2 bg-blue-100 rounded-lg">
                    <i class="fa-solid fa-receipt text-blue-600 text-xl"></i>
                </div>
            </div>
            <p class="text-sm text-gray-500 mt-4">Son 1 saatda: 12 satış</p>
        </div>

        <!-- Kart 3: Müştərilər -->
        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-purple-500">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-medium text-gray-500 uppercase tracking-wider">Müştərilər</p>
                    <h3 class="text-2xl font-bold text-gray-800 mt-1">892</h3>
                </div>
                <div class="p-2 bg-purple-100 rounded-lg">
                    <i class="fa-solid fa-users text-purple-600 text-xl"></i>
                </div>
            </div>
            <p class="text-sm text-purple-600 mt-4 flex items-center">
                <i class="fa-solid fa-user-plus mr-1"></i> +5 yeni bu gün
            </p>
        </div>

        <!-- Kart 4: Kritik Stok (Xəbərdarlıq) -->
        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-red-500">
            <div class="flex justify-between items-start">
                <div>
                    <p class="text-xs font-medium text-gray-500 uppercase tracking-wider">Kritik Stok</p>
                    <h3 class="text-2xl font-bold text-red-600 mt-1">12</h3>
                </div>
                <div class="p-2 bg-red-100 rounded-lg">
                    <i class="fa-solid fa-triangle-exclamation text-red-600 text-xl"></i>
                </div>
            </div>
            <p class="text-sm text-gray-500 mt-4">Məhsul bitmək üzrədir</p>
        </div>
    </div>

    <!-- Cədvəl Hissəsi (Son Satışlar) -->
    <div class="bg-white shadow-lg rounded-xl overflow-hidden border border-gray-100">
        <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center bg-gray-50">
            <h2 class="text-lg font-semibold text-gray-800">Son Satış Əməliyyatları</h2>
            <a href="#" class="text-blue-600 hover:text-blue-800 text-sm font-medium">Hamısına bax</a>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-gray-50 text-gray-600 text-xs uppercase tracking-wider">
                        <th class="px-6 py-3 font-semibold">Çek No</th>
                        <th class="px-6 py-3 font-semibold">Müştəri</th>
                        <th class="px-6 py-3 font-semibold">Tarix</th>
                        <th class="px-6 py-3 font-semibold">Məbləğ</th>
                        <th class="px-6 py-3 font-semibold">Status</th>
                        <th class="px-6 py-3 font-semibold text-right">Əməliyyat</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 text-sm">
                    <!-- Nümunə Sətir 1 -->
                    <tr class="hover:bg-gray-50 transition">
                        <td class="px-6 py-4 font-medium text-gray-900">#TRX-9823</td>
                        <td class="px-6 py-4 text-gray-600">Nəğd Satış</td>
                        <td class="px-6 py-4 text-gray-500">Bu gün, 14:30</td>
                        <td class="px-6 py-4 font-bold text-gray-800">24.50 ₼</td>
                        <td class="px-6 py-4">
                            <span class="px-2 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full">Tamamlandı</span>
                        </td>
                        <td class="px-6 py-4 text-right">
                            <button class="text-gray-400 hover:text-blue-600"><i class="fa-solid fa-eye"></i></button>
                        </td>
                    </tr>

                    <!-- Nümunə Sətir 2 -->
                    <tr class="hover:bg-gray-50 transition">
                        <td class="px-6 py-4 font-medium text-gray-900">#TRX-9822</td>
                        <td class="px-6 py-4 text-gray-600">Elvin Məmmədov</td>
                        <td class="px-6 py-4 text-gray-500">Bu gün, 14:15</td>
                        <td class="px-6 py-4 font-bold text-gray-800">105.00 ₼</td>
                        <td class="px-6 py-4">
                            <span class="px-2 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full">Tamamlandı</span>
                        </td>
                        <td class="px-6 py-4 text-right">
                            <button class="text-gray-400 hover:text-blue-600"><i class="fa-solid fa-eye"></i></button>
                        </td>
                    </tr>

                    <!-- Nümunə Sətir 3 -->
                    <tr class="hover:bg-gray-50 transition">
                        <td class="px-6 py-4 font-medium text-gray-900">#TRX-9821</td>
                        <td class="px-6 py-4 text-gray-600">Nəğd Satış</td>
                        <td class="px-6 py-4 text-gray-500">Bu gün, 13:45</td>
                        <td class="px-6 py-4 font-bold text-gray-800">8.20 ₼</td>
                        <td class="px-6 py-4">
                            <span class="px-2 py-1 text-xs font-semibold text-red-700 bg-red-100 rounded-full">Ləğv edildi</span>
                        </td>
                        <td class="px-6 py-4 text-right">
                            <button class="text-gray-400 hover:text-blue-600"><i class="fa-solid fa-eye"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
@endsection
