<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Offices_users extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'user_name',
        'user_phone',
        'user_address',
        'user_birthDate',
        'user_account_name',
        'user_account_password',
        'gender_id',
        'permission_type_id',
        'office_id',
    ];

    protected $hidden = ['user_account_password'];

    protected $dates = ['deleted_at'];



    public function permission_type()
    {
        return $this->belongsTo(Permission_type::class);
    }

    public function gender()
    {
        return $this->belongsTo(Gender::class);
    }

    public function office()
    {
        return $this->belongsTo(Office::class);
    }
}
