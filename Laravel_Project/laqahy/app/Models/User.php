<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
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
        'healthy_center_id',
        'deleted_at',
    ];

    // protected $hidden = ['user_account_password'];

    protected $dates = ['deleted_at'];


    public function gender()
    {
        return $this->belongsTo(Gender::class);
    }

    public function motherStatement()
    {
        return $this->hasMany(Mother_statement::class);
    }

    public function childStatement()
    {
        return $this->hasMany(Child_statement::class);
    }

    public function permission_type()
    {
        return $this->belongsTo(Permission_type::class);
    }

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }
}
