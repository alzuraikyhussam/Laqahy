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
}
