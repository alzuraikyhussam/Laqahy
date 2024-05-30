<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Directorate extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['directorate_name','cities_id'];

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }

    public function mother_data()
    {
        return $this->hasMany(Mother_data::class);
    }

    public function healthy_center()
    {
        return $this->hasMany(Healthy_center::class);
    }
}
