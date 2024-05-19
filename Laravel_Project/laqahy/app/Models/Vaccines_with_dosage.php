<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vaccines_with_dosage extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['vaccine_types_id','dosage_types_id'];
}
