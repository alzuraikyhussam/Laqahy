<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VisitWithChildVaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'visit_with_child_vaccine';
    protected $fillable = ['visit_type_id', 'child_vaccine_id'];
}
