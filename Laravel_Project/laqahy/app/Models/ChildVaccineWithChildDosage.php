<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChildVaccineWithChildDosage extends Model
{
    use HasFactory;
    public $timestamps = false;
    public $table = 'child_vaccine_with_child_dosage';
    protected $fillable = ['child_vaccine_id', 'child_dosage_type_id'];
}
