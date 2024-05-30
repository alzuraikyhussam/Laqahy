<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_centers_stock_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'healthy_center_id',
        'vaccine_type_id',
        'basic_quantity',
        'remaining_quantity',
    ];

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }
}
