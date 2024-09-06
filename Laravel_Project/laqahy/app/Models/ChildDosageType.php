<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChildDosageType extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $fillable = ['child_dosage_type'];

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function child_vaccine()
    {
        return $this->belongsToMany(ChildVaccine::class, 'child_vaccine_with_child_dosage');
    }
}
