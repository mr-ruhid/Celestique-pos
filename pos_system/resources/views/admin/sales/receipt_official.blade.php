<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <title>Satış Çeki - #{{ $order->receipt_code }}</title>
    <style>
        @page {
            margin: 0;
        }
        body {
            font-family: 'Courier New', Courier, monospace; /* Çek stili üçün monospace font */
            font-size: 12px;
            line-height: 1.4;
            color: #000;
            background: #fff;
            margin: 0;
            padding: 20px;
            width: 80mm; /* Standart termal kağız eni */
        }
        .container {
            width: 100%;
        }
        .header {
            text-align: center;
            margin-bottom: 10px;
        }
        .store-name {
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .font-bold { font-weight: bold; }
        .dashed-line {
            border-top: 1px dashed #000;
            margin: 8px 0;
        }
        .title {
            font-size: 14px;
            font-weight: bold;
            margin: 10px 0;
            text-transform: uppercase;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            text-align: left;
            border-bottom: 1px dashed #000;
            padding-bottom: 5px;
        }
        td {
            padding: 3px 0;
            vertical-align: top;
        }
        .totals-table td {
            padding: 1px 0;
        }
        .lottery-box {
            border: 2px solid #000;
            margin: 15px 0;
            padding: 10px;
            text-align: center;
        }
        .lottery-title {
            font-size: 10px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .lottery-code {
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .fiscal-info {
            font-size: 10px;
            margin-top: 10px;
        }
        .no-print {
            margin-bottom: 20px;
            padding: 10px;
            background: #f0f0f0;
            text-align: center;
        }
        @media print {
            .no-print { display: none; }
            body { padding: 0; margin: 0; }
        }
    </style>
</head>
<body>

    <!-- Çap Düymələri -->
    <div class="no-print">
        <button onclick="window.print()" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">Çap Et</button>
        <button onclick="window.close()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">Bağla</button>
    </div>

    <div class="container">
        <!-- Mağaza Məlumatları -->
        <div class="header">
            <div class="store-name">{{ $settings['store_name'] ?? 'RJ POS MARKET' }}</div>
            <div>{{ $settings['store_address'] ?? 'Bakı şəhəri' }}</div>
            <div>Tel: {{ $settings['store_phone'] ?? '+994 XX XXX XX XX' }}</div>
            <div class="font-bold">VÖEN: 1234567890</div>
            <div>Obyekt kodu: 000000</div>
        </div>

        <div class="dashed-line"></div>

        <div class="text-center">
            <div class="title">SATIŞ ÇEKİ</div>
            <div>Çek nömrəsi: #{{ $order->receipt_code }}</div>
        </div>

        <div style="margin-top: 10px;">
            <table style="font-size: 11px;">
                <tr>
                    <td>Kassa №: 01</td>
                    <td class="text-right">Tarix: {{ $order->created_at->format('d.m.Y') }}</td>
                </tr>
                <tr>
                    <td>Kassir: {{ $order->user->name ?? 'Admin' }}</td>
                    <td class="text-right">Saat: {{ $order->created_at->format('H:i:s') }}</td>
                </tr>
            </table>
        </div>

        <div class="dashed-line"></div>

        <!-- Məhsullar -->
        <table>
            <thead>
                <tr>
                    <th style="width: 50%;">Malın adı</th>
                    <th class="text-center">Miqdar</th>
                    <th class="text-right">Qiymət</th>
                    <th class="text-right">Toplam</th>
                </tr>
            </thead>
            <tbody>
                @foreach($order->items as $item)
                <tr>
                    <td>
                        {{ $item->product_name }}<br>
                        <small>*ƏDV-dən azad</small>
                    </td>
                    <td class="text-center">{{ $item->quantity }}</td>
                    <td class="text-right">{{ number_format($item->price, 2) }}</td>
                    <td class="text-right">{{ number_format($item->total, 2) }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>

        <div class="dashed-line"></div>

        <!-- Yekunlar -->
        <table class="totals-table">
            <tr>
                <td>ARA CƏM:</td>
                <td class="text-right">{{ number_format($order->subtotal, 2) }}</td>
            </tr>
            @if($order->total_discount > 0)
            <tr>
                <td>ENDİRİM:</td>
                <td class="text-right">-{{ number_format($order->total_discount, 2) }}</td>
            </tr>
            @endif
            <tr>
                <td class="font-bold" style="font-size: 14px;">YEKUN MƏBLƏĞ:</td>
                <td class="text-right font-bold" style="font-size: 14px;">{{ number_format($order->grand_total, 2) }} ₼</td>
            </tr>
        </table>

        <div class="dashed-line" style="margin-top: 15px;"></div>

        <!-- Ödəniş Detalları -->
        <table>
            <tr>
                <td>Ödəniş üsulu:</td>
                <td class="text-right">{{ $order->payment_method == 'cash' ? 'NƏĞD' : 'KART' }}</td>
            </tr>
            <tr>
                <td>Ödənilib:</td>
                <td class="text-right">{{ number_format($order->paid_amount, 2) }}</td>
            </tr>
            @if($order->change_amount > 0)
            <tr>
                <td>Qalıq (Sdat):</td>
                <td class="text-right">{{ number_format($order->change_amount, 2) }}</td>
            </tr>
            @endif
        </table>

        <!-- LOTOREYA KODU (Random Key) -->
        <div class="lottery-box">
            <div class="lottery-title">UDUŞLU LOTOREYA KODU</div>
            <div class="lottery-code">{{ $order->lottery_code }}</div>
            <div style="font-size: 9px; margin-top: 3px;">Kodu qeydiyyatdan keçirərək qalib olun!</div>
        </div>

        <!-- Fiskal Məlumatlar -->
        <div class="fiscal-info">
            <div>Gün ərzində vurulmuş çek: {{ $order->id % 1000 }}</div>
            <div>Kassa aparatı modeli: RJ-TECH V2</div>
            <div>Kassa aparatı zavod nömrəsi: RJ{{ date('Y') }}9988</div>
            <div class="font-bold">Fiscal ID: {{ strtoupper(substr(md5($order->id), 0, 12)) }}</div>
            <div>NMQ-nun qeydiyyat nömrəsi: 12345678</div>
        </div>

        <div class="dashed-line"></div>

        <div class="text-center" style="margin-top: 10px;">
            {{ $settings['receipt_footer'] ?? 'Bizi seçdiyiniz üçün təşəkkür edirik!' }}<br>
            <small>www.rj-pos.az</small>
        </div>

        <div style="height: 30px;"></div> <!-- Çapdan sonra asan qoparmaq üçün boşluq -->
    </div>

</body>
</html>
