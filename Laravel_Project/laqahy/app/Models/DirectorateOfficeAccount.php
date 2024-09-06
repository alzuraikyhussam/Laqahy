<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DirectorateOfficeAccount extends Model
{
    use HasFactory;

    protected $fillable = ['directorate_office_account_name', 'setup_code', 'directorate_office_account_phone', 'directorate_id', 'city_office_account_id', 'directorate_office_account_address', 'created_at', 'updated_at'];

    public function user()
    {
        return $this->morphMany(User::class, 'office_name');
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
        return $this->morphMany(Circulars::class, 'sen_office_name');
    }

    public function circulars_rec()
    {
        return $this->morphMany(Circulars::class, 'rec_office_name');
    }

    public function order()
    {
        return $this->morphMany(Order::class, 'office_name');
    }

    public function office_statement_stock_vaccine_office_name()
    {
        return $this->morphMany(VaccineStockStatement::class, 'office_name');
    }

    public function office_statement_stock_vaccine_vax_type()
    {
        return $this->morphMany(VaccineStockStatement::class, 'vaccine_type');
    }

    public function vaccine_stock_office_name()
    {
        return $this->morphMany(VaccineStock::class, 'office_name');
    }

    public function vaccine_stock_vax_type()
    {
        return $this->morphMany(VaccineStock::class, 'vaccine_type');
    }
}
