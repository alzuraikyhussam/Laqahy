<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ChildData extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'child_data_name',
        'mother_data_id',
        'child_data_birthplace',
        'child_data_birthDate',
        'gender_id',
        'healthy_center_account_id',
        // 'fcm_token',
    ];
    
    protected $dates = ['deleted_at'];
    protected $table = 'child_data';

    public function gender()
    {
        return $this->belongsTo(Gender::class);
    }

    public function mother_data()
    {
        return $this->belongsTo(MotherData::class);
    }

    public function child_statement()
    {
        return $this->hasMany(ChildStatement::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }
}
