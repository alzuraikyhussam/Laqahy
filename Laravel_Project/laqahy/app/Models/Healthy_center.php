<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Healthy_center extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'healthy_center_name',
        'create_account_code',
        'healthy_center_address',
        'healthy_center_phone',
        'healthy_center_installation_code',
        'directorate_id',
        'cities_id',
        'office_id',
    ];
    protected $dates = ['deleted_at'];

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function office()
    {
        return $this->belongsTo(Office::class);
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
}
