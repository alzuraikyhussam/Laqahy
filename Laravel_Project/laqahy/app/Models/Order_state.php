<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_state extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['order_state'];

    public function order()
    {
        return $this->hasOne(Order::class);
    }
}
