<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vaccine_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['vaccine_type'];

    public function ministry_stock_vaccine()
    {
        return $this->hasMany(Ministry_stock_vaccine::class);
    }

    public function ministry_statement_stock_vaccine()
    {
        return $this->hasMany(Ministry_statement_stock_vaccine::class);
    }

    public function healthy_center_stock_vaccine()
    {
        return $this->hasMany(Healthy_centers_stock_vaccine::class);
    }

    public function officeOrder()
    {
        return $this->hasMany(OfficeOrder::class);
    }

    public function healthyCenterOrder()
    {
        return $this->hasMany(HealthyCenterOrder::class);
    }

    public function child_statement()
    {
        return $this->hasMany(Child_statement::class);
    }

    public function child_dosage_type()
    {
        return $this->belongsToMany(Child_dosage_type::class,'vaccines_with_dosages');
    }

    public function visit_type()
    {
        return $this->belongsToMany(Visit_type::class);
    }

    public function officeStockVaccine()
    {
        return $this->hasMany(Office_stock_vaccine::class);
    }
}
