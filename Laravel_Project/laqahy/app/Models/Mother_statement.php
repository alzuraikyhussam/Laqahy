<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mother_statement extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'mother_datas_id',
        'healthy_centers_id',
        'health_employee_name',
        'date_taking_dose',
        'return_date',
        'dosage_types_id',
        'dosage_levels_id',
    ];
}
