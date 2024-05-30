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
        'directorate_id',
        'healthy_center_id',
    ];

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function child_data()
    {
        return $this->hasMany(Child_data::class);
    }

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(Mother_statement::class);
    }
}
