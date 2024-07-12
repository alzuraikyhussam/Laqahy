<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Child_dosage_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['child_dosage_type'];

    public function vaccine_type()
    {
        return $this->belongsToMany(Vaccine_type::class,'vaccines_with_dosages');
    }
}
