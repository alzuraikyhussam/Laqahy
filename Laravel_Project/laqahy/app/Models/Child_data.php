<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Child_data extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'child_data_name',
        'mother_datas_id',
        'child_data_birthplace',
        'child_data_birthdate',
        'genders_id',
    ];
}
