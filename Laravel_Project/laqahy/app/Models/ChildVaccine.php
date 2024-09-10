<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChildVaccine extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $fillable = ['child_vaccine_type'];

    public function order()
    {
        return $this->hasMany(Order::class, 'vaccine_type_id');
    }

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function visit_type()
    {
        return $this->belongsToMany(VisitType::class, 'visit_with_child_vaccine');
    }

    public function child_dosage_type()
    {
        return $this->belongsToMany(ChildDosageType::class, 'child_vaccine_with_child_dosage');
    }

    public function vaccine_stock()
    {
        return $this->hasMany(VaccineStock::class, 'vaccine_type_id');
    }

    public function vaccine_stock_statement()
    {
        return $this->hasMany(VaccineStock::class, 'vaccine_type_id');
    }
}
