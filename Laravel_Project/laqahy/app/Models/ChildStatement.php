<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ChildStatement extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'child_data_id',
        'healthy_center_account_id',
        'user_id',
        'date_taking_dose',
        'return_date',
        'visit_type_id',
        'child_vaccine_id',
        'child_dosage_type_id',
    ];

    protected $dates = ['deleted_at'];

    public function child_data()
    {
        return $this->belongsTo(ChildData::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function visit_type()
    {
        return $this->belongsTo(VisitType::class);
    }

    public function child_vaccine()
    {
        return $this->belongsTo(ChildVaccine::class);
    }

    public function child_dosage_type()
    {
        return $this->belongsTo(ChildDosageType::class);
    }
}
