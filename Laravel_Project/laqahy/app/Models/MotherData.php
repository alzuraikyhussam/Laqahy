<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class MotherData extends Authenticatable
{
    use HasFactory;
    use Notifiable;
    use HasApiTokens;
    use SoftDeletes;

    protected $fillable = [
        'mother_name',
        'mother_phone',
        'mother_birthDate',
        'mother_village',
        'mother_identity_num',
        'mother_password',
        'city_id',
        'directorate_id',
        'healthy_center_account_id',
        'fcm_token',
    ];

    protected $table = 'mother_data';

    protected $dates = ['deleted_at'];

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function child_data()
    {
        return $this->hasMany(ChildData::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }

    public function notification()
    {
        return $this->hasMany(Notification::class);
    }
}
