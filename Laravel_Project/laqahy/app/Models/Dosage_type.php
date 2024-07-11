<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dosage_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['dosage_type','dosage_level_id'];

    public function dosage_level()
    {
        return $this->belongsTo(Dosage_level::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(Mother_statement::class);
    }

    public function child_statement()
    {
        return $this->hasMany(Child_statement::class);
    }

}
