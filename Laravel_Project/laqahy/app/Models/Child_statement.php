<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Child_statement extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'child_data_id',
        'healthy_center_id',
        'user_id',
        'date_taking_dose',
        'return_date',
        'visit_type_id',
        'vaccine_type_id',
        'child_dosage_type_id',
    ];
    protected $dates = ['deleted_at'];

    public function child_data()
    {
        return $this->belongsTo(Child_data::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
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

    public function child_dosage_type()
    {
        return $this->belongsTo(Child_dosage_type::class);
    }
}
