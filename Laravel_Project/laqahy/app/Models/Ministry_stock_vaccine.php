<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Ministry_stock_vaccine extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'vaccine_type_id',
        'quantity',
    ];
    protected $dates = ['deleted_at'];

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }
}
