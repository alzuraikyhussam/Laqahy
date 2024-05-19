<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vaccine_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['vaccine_type'];
}
