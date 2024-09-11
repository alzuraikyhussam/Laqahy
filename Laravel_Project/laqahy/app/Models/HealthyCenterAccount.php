<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class HealthyCenterAccount extends Model
{
    use HasFactory, SoftDeletes;

    protected $dates = ['deleted_at'];

    protected $fillable = ['healthy_center_account_name', 'setup_code', 'healthy_center_account_phone', 'healthy_center_account_address', 'directorate_office_account_id'];

    public function directorate_office_account()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }

    public function users()
    {
        return $this->hasMany(User::class, 'office_account_id');
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

    public function mother_data()
    {
        return $this->hasMany(MotherData::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function child_data()
    {
        return $this->hasMany(ChildData::class);
    }
}
