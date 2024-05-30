<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ministry_stock_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'vaccine_type_id',
        'quantity',
    ];

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }
}
