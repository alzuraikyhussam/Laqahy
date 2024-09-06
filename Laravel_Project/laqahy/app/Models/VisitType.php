<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VisitType extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['visit_period'];

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function child_vaccine()
    {
        return $this->belongsToMany(ChildVaccine::class, 'visit_with_child_vaccine');
    }
}
