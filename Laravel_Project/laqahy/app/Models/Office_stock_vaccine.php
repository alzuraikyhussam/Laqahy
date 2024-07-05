<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Office_stock_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['office_id', 'vaccine_type_id', 'quantity'];

    protected $table = 'offices_stock_vaccines';

    public function office()
    {
        return $this->belongsTo(Office::class);
    }

    public function vaccineType()
    {
        return $this->belongsTo(Vaccine_type::class);
    }
}
