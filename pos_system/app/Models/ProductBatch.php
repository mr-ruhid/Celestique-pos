<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductBatch extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'cost_price',
        'initial_quantity',
        'current_quantity',
        'batch_code',
        'expiration_date'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
