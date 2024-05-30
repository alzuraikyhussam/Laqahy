<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Child_statement extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'child_data_id',
        'healthy_center_id',
        'health_employee_name',
        'date_taking_dose',
        'return_date',
        'visit_type_id',
        'vaccine_type_id',
        'dosage_type_id',
    ];

    public function child_data()
    {
        return $this->belongsTo(Child_data::class);
    }

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function visit_type()
    {
        return $this->belongsTo(Visit_type::class);
    }

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }

    public function dosage_type()
    {
        return $this->belongsTo(Dosage_type::class);
    }
}
