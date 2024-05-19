<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mother_data extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'mother_name',
        'mother_phone',
        'mother_birthdate',
        'mother_village',
        'mother_password',
        'cities_id',
        'directorates_id',
        'healthy_centers_id',
    ];
}
