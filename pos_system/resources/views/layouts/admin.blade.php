<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RJ POS v2 - İdarəetmə Paneli</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

    <!-- İkonlar -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        [x-cloak] { display: none !important; }
        .sidebar-active { background-color: #374151; border-left: 4px solid #3B82F6; }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #1f2937; }
        ::-webkit-scrollbar-thumb { background: #4b5563; border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: #6b7280; }
    </style>
</head>
<body class="bg-gray-100 font-sans antialiased" x-data="{ sidebarOpen: true }">

    <div class="flex h-screen overflow-hidden">

        <!-- SIDEBAR -->
        <aside class="bg-gray-900 text-white flex flex-col transition-all duration-300 ease-in-out shadow-xl z-20"
               :class="sidebarOpen ? 'w-64' : 'w-20'">

            <!-- Logo -->
            <div class="h-16 flex items-center justify-center bg-gray-800 shadow-md border-b border-gray-700">
                <i class="fa-solid fa-cash-register text-2xl text-blue-500"></i>
                <span class="ml-3 text-xl font-bold tracking-wider" x-show="sidebarOpen">RJ POS <span class="text-blue-500">v2</span></span>
            </div>

            <!-- Menyu -->
            <div class="flex-1 overflow-y-auto py-4">
                <nav class="space-y-1 px-2">

                    <!-- 1. Ana Səhifə -->
                    <a href="{{ route('dashboard') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 transition-colors {{ request()->routeIs('dashboard') ? 'bg-gray-800 text-white' : '' }}">
                        <i class="fa-solid fa-chart-pie mr-3 text-lg w-6 text-center"></i>
                        <span x-show="sidebarOpen">Ana Səhifə</span>
                    </a>

                    <!-- 2. Kassa (POS) -->
                    <a href="{{ route('pos.index') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md bg-gradient-to-r from-blue-600 to-blue-700 text-white hover:from-blue-700 hover:to-blue-800 my-4 shadow-lg transform hover:scale-[1.02] transition-all">
                        <i class="fa-solid fa-desktop mr-3 text-lg w-6 text-center"></i>
                        <span x-show="sidebarOpen">KASSA EKRANI</span>
                    </a>

                    <!-- 3. Məhsul İdarəsi -->
                    <div x-data="{ open: {{ request()->routeIs('products.*') || request()->routeIs('categories.*') ? 'true' : 'false' }} }">
                        <button @click="open = !open" class="w-full group flex items-center justify-between px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 focus:outline-none transition-colors">
                            <div class="flex items-center">
                                <i class="fa-solid fa-box-open mr-3 text-lg w-6 text-center"></i>
                                <span x-show="sidebarOpen">Məhsullar</span>
                            </div>
                            <i class="fa-solid fa-chevron-down text-xs transition-transform duration-200" :class="open ? 'transform rotate-180' : ''" x-show="sidebarOpen"></i>
                        </button>
                        <div x-show="open && sidebarOpen" x-cloak class="space-y-1 pl-11 pr-2 bg-gray-800/50 py-2 rounded-md mt-1 border-l-2 border-gray-700 ml-2">
                            <a href="{{ route('products.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Məhsul Siyahısı</a>
                            <a href="{{ route('products.create') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Yeni Məhsul</a>
                            <a href="{{ route('categories.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Kateqoriyalar</a>
                            <a href="{{ route('products.barcodes') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Barkod Çapı</a>
                            <!-- Mağaza Endirimləri -->
                            <a href="{{ route('products.discounts') }}" class="block px-2 py-2 text-sm text-orange-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">
                                <i class="fa-solid fa-percent mr-1 text-xs"></i> Mağaza Endirimləri
                            </a>
                        </div>
                    </div>

                    <!-- 4. Stok və Anbar -->
                    <div x-data="{ open: {{ request()->routeIs('stocks.*') || request()->routeIs('suppliers.*') ? 'true' : 'false' }} }">
                        <button @click="open = !open" class="w-full group flex items-center justify-between px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 focus:outline-none transition-colors">
                            <div class="flex items-center">
                                <i class="fa-solid fa-warehouse mr-3 text-lg w-6 text-center"></i>
                                <span x-show="sidebarOpen">Stok və Anbar</span>
                            </div>
                            <i class="fa-solid fa-chevron-down text-xs transition-transform duration-200" :class="open ? 'transform rotate-180' : ''" x-show="sidebarOpen"></i>
                        </button>
                        <div x-show="open && sidebarOpen" x-cloak class="space-y-1 pl-11 pr-2 bg-gray-800/50 py-2 rounded-md mt-1 border-l-2 border-gray-700 ml-2">

                            <!-- YENİLƏNİB: Ümumi Stok geri qaytarıldı -->
                            <a href="{{ route('stocks.index') }}" class="block px-2 py-2 text-sm font-semibold text-blue-300 hover:text-white hover:bg-gray-700 rounded-md transition-colors">
                                <i class="fa-solid fa-chart-pie mr-1 text-xs"></i> Ümumi Stok
                            </a>

                            <a href="{{ route('stocks.store') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors ml-2 border-l border-gray-600 pl-3">
                                <i class="fa-solid fa-shop mr-1 text-xs"></i> Mağaza Stoku
                            </a>
                            <a href="{{ route('stocks.warehouse') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors ml-2 border-l border-gray-600 pl-3">
                                <i class="fa-solid fa-warehouse mr-1 text-xs"></i> Anbar Stoku
                            </a>
                            <a href="{{ route('stocks.transfer') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Stok Transferi</a>

                            <!-- Təchizatçılar (v3) -->
                            <div class="mt-2 p-2 rounded bg-gray-800 border border-gray-700/50">
                                <div class="flex items-center justify-between text-gray-500 text-sm mb-1 opacity-75">
                                    <span><i class="fa-solid fa-truck-field mr-1"></i> Təchizatçılar</span>
                                    <span class="text-[9px] bg-yellow-900 text-yellow-200 px-1 rounded border border-yellow-700">v3</span>
                                </div>
                                <a href="https://ruhidjavadov.site/app/rjpos/yenilikler.html" target="_blank" class="block text-center px-2 py-1.5 bg-gray-700 hover:bg-gray-600 text-gray-300 hover:text-white text-xs rounded transition-all">
                                    Yeniliklər
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- 5. Satışlar -->
                    <div x-data="{ open: {{ request()->routeIs('sales.*') || request()->routeIs('returns.*') ? 'true' : 'false' }} }">
                        <button @click="open = !open" class="w-full group flex items-center justify-between px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 focus:outline-none transition-colors">
                            <div class="flex items-center">
                                <i class="fa-solid fa-file-invoice-dollar mr-3 text-lg w-6 text-center"></i>
                                <span x-show="sidebarOpen">Satışlar</span>
                            </div>
                            <i class="fa-solid fa-chevron-down text-xs transition-transform duration-200" :class="open ? 'transform rotate-180' : ''" x-show="sidebarOpen"></i>
                        </button>
                        <div x-show="open && sidebarOpen" x-cloak class="space-y-1 pl-11 pr-2 bg-gray-800/50 py-2 rounded-md mt-1 border-l-2 border-gray-700 ml-2">
                            <a href="{{ route('sales.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Satış Tarixçəsi</a>
                            <a href="{{ route('returns.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Geri Qaytarma</a>
                        </div>
                    </div>

                    <!-- 6. Lotoreyalar -->
                    <a href="{{ route('lotteries.index') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 transition-colors {{ request()->routeIs('lotteries.*') ? 'bg-gray-800 text-white' : '' }}">
                        <i class="fa-solid fa-ticket mr-3 text-lg w-6 text-center text-yellow-500"></i>
                        <span x-show="sidebarOpen">Lotoreyalar</span>
                    </a>

                    <!-- 7. Endirimlər -->
                    <div x-data="{ open: {{ request()->routeIs('discounts.*') ? 'true' : 'false' }} }">
                        <button @click="open = !open" class="w-full group flex items-center justify-between px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 focus:outline-none transition-colors">
                            <div class="flex items-center">
                                <i class="fa-solid fa-tags mr-3 text-lg w-6 text-center"></i>
                                <span x-show="sidebarOpen">Kampaniyalar</span>
                            </div>
                            <i class="fa-solid fa-chevron-down text-xs transition-transform duration-200" :class="open ? 'transform rotate-180' : ''" x-show="sidebarOpen"></i>
                        </button>
                        <div x-show="open && sidebarOpen" x-cloak class="space-y-1 pl-11 pr-2 bg-gray-800/50 py-2 rounded-md mt-1 border-l-2 border-gray-700 ml-2">
                            <a href="{{ route('discounts.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Ümumi Kampaniyalar</a>
                            <a href="{{ route('promocodes.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Promokodlar</a>
                            <a href="{{ route('partners.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Partnyor Endirimləri</a>
                        </div>
                    </div>

                    <!-- 8. Hesabatlar -->
                    <a href="{{ route('reports.index') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 transition-colors {{ request()->routeIs('reports.*') ? 'bg-gray-800 text-white' : '' }}">
                        <i class="fa-solid fa-chart-line mr-3 text-lg w-6 text-center"></i>
                        <span x-show="sidebarOpen">Hesabatlar</span>
                    </a>

                    <!-- 9. TƏNZİMLƏMƏLƏR -->
                    <div class="mt-4 pt-4 border-t border-gray-700">
                        <div x-data="{ open: {{ request()->routeIs('settings.*') || request()->routeIs('roles.*') ? 'true' : 'false' }} }">
                            <button @click="open = !open" class="w-full group flex items-center justify-between px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 focus:outline-none transition-colors">
                                <div class="flex items-center">
                                    <i class="fa-solid fa-gears mr-3 text-lg w-6 text-center text-gray-400 group-hover:text-white"></i>
                                    <span x-show="sidebarOpen">Tənzimləmələr</span>
                                </div>
                                <i class="fa-solid fa-chevron-down text-xs transition-transform duration-200" :class="open ? 'transform rotate-180' : ''" x-show="sidebarOpen"></i>
                            </button>
                            <div x-show="open && sidebarOpen" x-cloak class="space-y-1 pl-11 pr-2 bg-gray-800/50 py-2 rounded-md mt-1 border-l-2 border-gray-700 ml-2">
                                <a href="{{ route('settings.store') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Mağaza Məlumatları</a>
                                <a href="{{ route('settings.registers') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Kassalar</a>
                                <a href="{{ route('roles.index') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors {{ request()->routeIs('roles.*') ? 'text-white bg-gray-700' : '' }}">Rollar və İcazələr</a>
                                <a href="{{ route('settings.taxes') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Vergi Dərəcələri</a>
                                <a href="{{ route('settings.payments') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Ödəniş Növləri</a>
                                <a href="{{ route('settings.receipt') }}" class="block px-2 py-2 text-sm text-gray-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">Qəbz Şablonu</a>
                                <a href="{{ route('settings.api') }}" class="block px-2 py-2 text-sm text-yellow-400 hover:text-white hover:bg-gray-700 rounded-md transition-colors">
                                    <i class="fa-solid fa-code mr-1"></i> API Tənzimləmələri
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- 10. SİSTEM (YENİLƏNİB) -->
                    <div class="mt-2 space-y-2">

                        <!-- Backup və Restore -->
                        <a href="{{ route('system.backup') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 transition-colors">
                            <i class="fa-solid fa-database mr-3 text-lg w-6 text-center text-green-500"></i>
                            <span x-show="sidebarOpen">Backup və Restore</span>
                        </a>

                        <!-- Sistem Yeniləmələri (YENİ) -->
                        <a href="{{ route('system.updates') }}" class="group flex items-center px-2 py-3 text-sm font-medium rounded-md hover:bg-gray-700 hover:text-white text-gray-300 transition-colors">
                            <i class="fa-solid fa-cloud-arrow-down mr-3 text-lg w-6 text-center text-blue-400"></i>
                            <span x-show="sidebarOpen">Sistem Yeniləmələri</span>
                        </a>

                        <!-- Dillər və Tərcümə (v3) -->
                        <div x-show="sidebarOpen" class="mt-2 p-2 rounded bg-gray-800 border border-gray-700/50 mx-2">
                            <div class="flex items-center justify-between text-gray-500 text-sm mb-1 opacity-75">
                                <span><i class="fa-solid fa-language mr-1"></i> Dillər və Tərcümə</span>
                                <span class="text-[9px] bg-yellow-900 text-yellow-200 px-1 rounded border border-yellow-700">v3</span>
                            </div>
                            <p class="text-[10px] text-gray-400 mb-2 leading-tight">Çoxdilli sistem dəstəyi v3-də aktiv olacaq.</p>
                            <a href="https://ruhidjavadov.site/app/rjpos/yenilikler.html" target="_blank" class="block text-center px-2 py-1.5 bg-gradient-to-r from-blue-900 to-blue-800 hover:from-blue-700 hover:to-blue-600 text-blue-100 hover:text-white text-xs rounded transition-all shadow-sm border border-blue-800 group-hover:shadow-blue-900/50">
                                <i class="fa-solid fa-rocket mr-1"></i> Yeniliklər barədə toxunun
                            </a>
                        </div>

                    </div>

                </nav>
            </div>

             <!-- İstifadəçi Profil -->
             <div class="border-t border-gray-800 p-4 bg-gray-900">
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 relative">
                            <img class="h-8 w-8 rounded-full bg-gray-500 border border-gray-600" src="https://ui-avatars.com/api/?name=Admin+User&background=0D8ABC&color=fff" alt="">
                            <span class="absolute bottom-0 right-0 block h-2 w-2 rounded-full bg-green-400 ring-2 ring-gray-900"></span>
                        </div>
                        <div class="ml-3" x-show="sidebarOpen">
                            <p class="text-sm font-medium text-white">Admin</p>
                            <p class="text-xs text-gray-400">RJ POS v2</p>
                        </div>
                    </div>
                    <button x-show="sidebarOpen" class="text-gray-400 hover:text-white transition-colors">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </button>
                </div>
            </div>
        </aside>

        <!-- MAIN CONTENT -->
        <div class="flex-1 flex flex-col overflow-hidden">
            <header class="bg-white shadow-sm h-16 flex items-center justify-between px-6 z-10 border-b border-gray-200">
                <button @click="sidebarOpen = !sidebarOpen" class="text-gray-500 hover:text-gray-700 focus:outline-none transition-colors">
                    <i class="fa-solid fa-bars text-xl"></i>
                </button>
                <div class="flex items-center space-x-4">
                     <!-- Axtarış -->
                    <div class="hidden md:flex relative text-gray-400 focus-within:text-gray-600 mr-4">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fa-solid fa-search"></i>
                        </div>
                        <input name="search" id="search" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 sm:text-sm transition duration-150 ease-in-out" placeholder="Sistemdə axtar..." type="search">
                    </div>
                     <!-- Bildiriş -->
                    <button class="relative p-2 text-gray-400 hover:text-gray-600 transition-colors">
                        <i class="fa-regular fa-bell text-xl"></i>
                        <span class="absolute top-1 right-1 block h-2 w-2 rounded-full bg-red-500 ring-2 ring-white"></span>
                    </button>
                    <!-- Server Status -->
                    <div class="flex items-center px-3 py-1 rounded-full bg-green-50 text-green-700 text-xs font-medium border border-green-200">
                        <span class="relative flex h-2 w-2 mr-2">
                          <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                          <span class="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
                        </span>
                        Online
                    </div>
                </div>
            </header>

            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                {{-- Buraya hər səhifənin öz kodu gələcək --}}
                @yield('content')
            </main>
        </div>
    </div>
</body>
</html>
