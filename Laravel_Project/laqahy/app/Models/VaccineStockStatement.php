<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class VaccineStockStatement extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'vaccine_type',
        'quantity',
        'date',
        'office_type_id',
        'office_name',
        'donor_id',
    ];

    public $timestamps = false;

    protected $dates = ['deleted_at'];

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

    public function donor()
    {
        return $this->belongsTo(Donor::class);
    }
}
