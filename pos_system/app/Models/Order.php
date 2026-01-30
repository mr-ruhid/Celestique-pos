<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Order extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'user_id',
        'cash_register_id',
        'receipt_code',
        'subtotal',
        'total_discount',
        'total_tax',
        'grand_total',
        'total_cost',
        'paid_amount',
        'change_amount',
        'payment_method',
        'status'
    ];

    protected $casts = [
        'subtotal' => 'decimal:2',
        'total_discount' => 'decimal:2',
        'total_tax' => 'decimal:2',
        'grand_total' => 'decimal:2',
        'total_cost' => 'decimal:2',
        'paid_amount' => 'decimal:2',
        'change_amount' => 'decimal:2',
    ];

    // Satışın içindəki məhsullar
    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }

    // Satışı edən kassir
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Hansı kassada edilib
    public function cashRegister()
    {
        return $this->belongsTo(CashRegister::class);
    }
}
