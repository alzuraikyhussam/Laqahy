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
        return $this->morphMany(Order::class, 'vaccine_type');
    }

    public function dosage_level()
    {
        return $this->hasMany(DosageLevel::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }
}
