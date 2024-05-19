<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Child_statement extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'child_datas_id',
        'healthy_centers_id',
        'health_employee_name',
        'date_taking_dose',
        'return_date',
        'visit_types_id',
        'vaccine_types_id',
        'dosage_types_id',
    ];
}
