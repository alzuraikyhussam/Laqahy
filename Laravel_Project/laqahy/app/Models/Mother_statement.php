<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Mother_statement extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'mother_data_id',
        'healthy_center_id',
        'health_employee_name',
        'date_taking_dose',
        'return_date',
        'dosage_type_id',
        'dosage_level_id',
    ];

    protected $dates = ['deleted_at'];

    public function mother_data()
    {
        return $this->belongsTo(Mother_data::class);
    }

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function dosage_level()
    {
        return $this->belongsTo(Dosage_level::class);
    }

    public function dosage_type()
    {
        return $this->belongsTo(Dosage_type::class);
    }
}
