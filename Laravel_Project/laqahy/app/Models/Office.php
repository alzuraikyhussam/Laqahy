<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Office extends Model
{
    use HasFactory;
    
    protected $fillable = ['office_name', 'cities_id', 'create_account_code', 'office_phone', 'office_address', 'created_at', 'updated_at'];

    public function officeStockVaccine()
    {
        return $this->hasMany(Office_stock_vaccine::class);
    }

    public function healthyCenter()
    {
        return $this->hasMany(Healthy_center::class);
    }

    public function officeOrder()
    {
        return $this->hasMany(OfficeOrder::class);
    }

    public function officeUser()
    {
        return $this->hasMany(Offices_users::class);
    }

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }
}
