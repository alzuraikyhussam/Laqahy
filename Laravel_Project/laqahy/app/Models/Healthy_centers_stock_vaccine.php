<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Healthy_centers_stock_vaccine extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'healthy_center_id',
        'vaccine_type_id',
        'basic_quantity',
        'remaining_quantity',
    ];
    protected $dates = ['deleted_at'];

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }
}
