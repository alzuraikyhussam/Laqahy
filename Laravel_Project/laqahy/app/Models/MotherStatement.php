<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MotherStatement extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'mother_data_id',
        'healthy_center_account_id',
        'user_id',
        'date_taking_dose',
        'return_date',
        'mother_vaccine_id',
        'mother_dosage_type_id',
        'dosage_level_id',
    ];

    protected $dates = ['deleted_at'];

    public function mother_data()
    {
        return $this->belongsTo(MotherData::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function dosage_level()
    {
        return $this->belongsTo(DosageLevel::class);
    }

    public function mother_dosage_type()
    {
        return $this->belongsTo(MotherDosageType::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function mother_vaccine()
    {
        return $this->belongsTo(MotherVaccine::class);
    }
}
