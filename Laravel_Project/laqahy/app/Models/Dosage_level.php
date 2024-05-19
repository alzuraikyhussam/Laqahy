<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dosage_level extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['dosage_level'];
}
