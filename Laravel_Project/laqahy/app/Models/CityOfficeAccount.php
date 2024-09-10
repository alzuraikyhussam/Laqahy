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

    public function users()
    {
        return $this->hasMany(User::class, 'office_account_id');
    }

    public function circulars_sen()
    {
        return $this->hasMany(Circulars::class, 'sen_office_id');
    }

    public function circulars_rec()
    {
        return $this->hasMany(Circulars::class, 'rec_office_id');
    }

    public function vaccine_stock_statement()
    {
        return $this->hasMany(VaccineStockStatement::class, 'office_account_id');
    }

    public function vaccine_stock()
    {
        return $this->hasMany(VaccineStock::class, 'office_account_id');
    }

    public function order()
    {
        return $this->hasMany(Order::class, 'office_account_id');
    }
}
