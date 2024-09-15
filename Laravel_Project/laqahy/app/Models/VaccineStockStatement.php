<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class VaccineStockStatement extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'vaccine_type_id',
        'vaccine_statement_quantity',
        'vaccine_statement_date',
        'office_type_id',
        'office_account_id',
        'donor_id',
        'vaccine_category',
    ];

    public $timestamps = false;

    protected $dates = ['deleted_at'];

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function city_office_account()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function directorate_office_account()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function mother_vaccine()
    {
        return $this->belongsTo(MotherVaccine::class);
    }

    public function child_vaccine()
    {
        return $this->belongsTo(ChildVaccine::class);
    }

    public function donor()
    {
        return $this->belongsTo(Donor::class);
    }
}
