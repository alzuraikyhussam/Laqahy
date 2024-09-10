<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use Notifiable;
    use SoftDeletes;
    use HasApiTokens;

    protected $fillable = [
        'user_name',
        'user_phone',
        'user_address',
        'user_birthDate',
        'user_account_name',
        'user_account_password',
        'gender_id',
        'permission_type_id',
        'office_type_id',
        'office_account_id',
        'deleted_at',
    ];

    // protected $hidden = ['user_account_password'];

    protected $dates = ['deleted_at'];

    public function city_office_account()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function directorate_office_account()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function gender()
    {
        return $this->belongsTo(Gender::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(MotherStatement::class);
    }

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function permission_type()
    {
        return $this->belongsTo(PermissionType::class);
    }

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }
}
