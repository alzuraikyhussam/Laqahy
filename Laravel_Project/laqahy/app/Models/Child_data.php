<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Child_data extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'child_data_name',
        'mother_datas_id',
        'child_data_birthplace',
        'child_data_birthdate',
        'gender_id',
    ];
    protected $dates = ['deleted_at'];


    public function gender()
    {
        return $this->belongsTo(Gender::class);
    }

    public function mother_data()
    {
        return $this->belongsTo(Mother_data::class);
    }

    public function child_statement()
    {
        return $this->hasMany(Child_statement::class);
    }
}
