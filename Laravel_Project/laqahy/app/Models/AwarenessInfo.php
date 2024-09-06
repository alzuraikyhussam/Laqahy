<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AwarenessInfo extends Model
{
    use HasFactory;
    use SoftDeletes;

    public $timestamps = false;
    protected $table = 'awareness_info';
    protected $fillable = ['awareness_title', 'awareness_description', 'awareness_date'];
    protected $dates = ['deleted_at'];
}
