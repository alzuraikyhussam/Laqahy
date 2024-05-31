<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dosage_level extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['dosage_level'];

    public function dosage_type()
    {
        return $this->hasMany(Dosage_type::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(Mother_statement::class);
    }
}
