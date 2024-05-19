<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_centers_stock_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'healthy_centers_id',
        'vaccine_types_id',
        'basic_quantity',
        'remaining_quantity',
    ];
}
