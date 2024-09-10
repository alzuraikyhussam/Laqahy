<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MotherVaccine extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $fillable = ['mother_vaccine_type'];

    public function order()
    {
        return $this->hasMany(Order::class, 'vaccine_type_id');
    }

    public function dosage_level()
    {
        return $this->hasMany(DosageLevel::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
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
