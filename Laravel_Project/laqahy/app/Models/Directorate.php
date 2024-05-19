<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Directorate extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['directorate_name','cities_id'];
}
