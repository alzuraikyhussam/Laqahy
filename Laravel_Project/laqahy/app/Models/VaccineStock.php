<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VaccineStock extends Model
{
    use HasFactory;

    protected $table = 'vaccine_stock';

    protected $fillable = [
        'vaccine_type',
        'quantity',
        'office_name',
        'office_type',
    ];

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function office_name()
    {
        return $this->morphTo();
    }

    public function vaccine_type()
    {
        return $this->morphTo();
    }
}
