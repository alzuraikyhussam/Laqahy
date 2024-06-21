<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Visit_with_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['visit_type_id', 'vaccine_type_id'];
}
