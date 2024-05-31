<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Visit_type extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['visit_period'];

    public function child_statement()
    {
        return $this->hasMany(Child_statement::class);
    }

    public function vaccine_type()
    {
        return $this->belongsToMany(Vaccine_type::class);
    }
}
