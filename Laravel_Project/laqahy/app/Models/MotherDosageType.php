<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MotherDosageType extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $fillable = ['mother_dosage_type', 'dosage_level_id'];

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }

    public function dosage_level()
    {
        return $this->belongsTo(DosageLevel::class);
    }
}
