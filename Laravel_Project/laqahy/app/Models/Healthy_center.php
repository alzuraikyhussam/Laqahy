<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_center extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'healthy_center_name',
        'healthy_center_address',
        'healthy_center_phone',
        'healthy_center_installation_cod',
        'directorate_id',
        'cities_id',
    ];

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function mother_data()
    {
        return $this->hasMany(Mother_data::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(Mother_statement::class);
    }

    public function child_statement()
    {
        return $this->hasMany(Child_statement::class);
    }

    public function stock_vaccine()
    {
        return $this->hasOne(Healthy_centers_stock_vaccine::class);
    }

    public function order()
    {
        return $this->hasMany(Order::class);
    }

    public function healthy_center_accounts()
    {
        return $this->hasMany(Healthy_center_account::class);
    }
}
