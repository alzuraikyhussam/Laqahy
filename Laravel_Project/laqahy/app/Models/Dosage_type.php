<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dosage_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['dosage_type','dosage_levels_id'];


}
