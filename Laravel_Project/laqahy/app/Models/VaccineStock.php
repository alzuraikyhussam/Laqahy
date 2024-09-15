<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VaccineStock extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $table = 'vaccine_stock';

    protected $fillable = [
        'vaccine_type_id',
        'vaccine_quantity',
        'office_account_id',
        'office_type_id',
        'vaccine_category',
    ];

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
}
