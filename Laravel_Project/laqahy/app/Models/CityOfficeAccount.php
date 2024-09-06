<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CityOfficeAccount extends Model
{
    use HasFactory;

    protected $fillable = ['city_office_account_name', 'setup_code', 'city_office_account_phone', 'city_id', 'office_type_id', 'city_office_account_address', 'created_at', 'updated_at'];

    public function posts()
    {
        return $this->hasMany(Post::class);
    }

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function directorate_office_account()
    {
        return $this->hasMany(DirectorateOfficeAccount::class);
    }

    public function user()
    {
        return $this->morphMany(User::class, 'office_name');
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
