<?php

namespace App\Models;

use Directory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cities extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['city_name'];

    public function directorate()
    {
        return $this->hasMany(Directorate::class);
    }

    public function healthy_center()
    {
        return $this->hasMany(Healthy_center::class);
    }

    public function mother_data()
    {
        return $this->hasMany(Mother_data::class);
    }

    public function office()
    {
        return $this->hasMany(Office::class);
    }
}
