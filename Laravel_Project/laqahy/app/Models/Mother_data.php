<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Mother_data extends Authenticatable
{
    use HasFactory;
    use Notifiable;
    use SoftDeletes;
    protected $fillable = [
        'mother_name',
        'mother_phone',
        'mother_birthDate',
        'mother_village',
        'mother_identity_num',
        'mother_password',
        'cities_id',
        'directorate_id',
        'healthy_center_id',
    ];

    protected $table = 'mother_data';

    protected $dates = ['deleted_at'];

    public function city()
    {
        return $this->belongsTo(Cities::class);
    }

    public function directorate()
    {
        return $this->belongsTo(Directorate::class);
    }

    public function child_data()
    {
        return $this->hasMany(Child_data::class);
    }

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function mother_statement()
    {
        return $this->hasMany(Mother_statement::class);
    }
}
