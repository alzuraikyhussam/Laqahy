<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_center extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'healthy_center_name',
        'healthy_center_address',
        'healthy_center_phone',
        'healthy_center_installation_cod',
        'directorates_id',
        'cities_id',
    ];
}
