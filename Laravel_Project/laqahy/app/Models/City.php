<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['city_name'];

    public function directorate()
    {
        return $this->hasMany(Directorate::class);
    }

    public function healthy_center_account()
    {
        return $this->hasMany(HealthyCenterAccount::class);
    }

    public function mother_data()
    {
        return $this->hasMany(MotherData::class);
    }

    public function city_office_account()
    {
        return $this->hasMany(CityOfficeAccount::class);
    }
}
