<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OfficeType extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['office_type'];

    public function user()
    {
        return $this->hasMany(User::class);
    }

    public function city_office_account()
    {
        return $this->hasMany(CityOfficeAccount::class);
    }

    public function circulars()
    {
        return $this->hasMany(Circulars::class);
    }

    public function order()
    {
        return $this->hasMany(Order::class);
    }

    public function vaccine_stock_statement()
    {
        return $this->hasMany(VaccineStockStatement::class);
    }

    public function vaccine_stock()
    {
        return $this->hasMany(VaccineStock::class);
    }

    public function posts()
    {
        return $this->hasMany(Post::class);
    }
}
