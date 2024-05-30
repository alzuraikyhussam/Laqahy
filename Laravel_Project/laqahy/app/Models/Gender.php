<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gender extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['gender_type'];

    public function user()
    {
        return $this->hasMany(User::class);
    }

    public function child_data()
    {
        return $this->hasMany(Child_data::class);
    }
}
