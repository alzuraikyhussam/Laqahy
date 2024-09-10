<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DirectorateOfficeAccount extends Model
{
    use HasFactory;

    protected $fillable = ['directorate_office_account_name', 'setup_code', 'directorate_office_account_phone', 'directorate_id', 'city_office_account_id', 'directorate_office_account_address', 'created_at', 'updated_at'];

    public function users()
    {
        return $this->hasMany(User::class, 'office_account_id');
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function city_office_account()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function healthy_center_account()
    {
        return $this->hasMany(HealthyCenterAccount::class);
    }

    public function circulars_sen()
    {
        return $this->hasMany(Circulars::class, 'sen_office_id');
    }

    public function circulars_rec()
    {
        return $this->hasMany(Circulars::class, 'rec_office_id');
    }

    public function order()
    {
        return $this->hasMany(Order::class, 'office_account_id');
    }

    public function vaccine_stock_statement()
    {
        return $this->hasMany(VaccineStockStatement::class, 'office_account_id');
    }

    public function vaccine_stock()
    {
        return $this->hasMany(VaccineStock::class, 'office_account_id');
    }
}
