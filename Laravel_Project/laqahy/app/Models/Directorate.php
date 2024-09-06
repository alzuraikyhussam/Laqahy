<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Directorate extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['directorate_name', 'city_id'];

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    public function mother_data()
    {
        return $this->hasMany(MotherData::class);
    }

    public function directorate_office_account()
    {
        return $this->hasMany(DirectorateOfficeAccount::class);
    }
}
