<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DosageLevel extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['dosage_level', 'mother_vaccine_id'];

    public function mother_vaccine()
    {
        return $this->belongsTo(MotherVaccine::class);
    }

    public function mother_dosage_type()
    {
        return $this->hasMany(MotherDosageType::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }
}
