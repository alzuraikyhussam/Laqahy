<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Notification extends Model
{
    use HasFactory;

    use SoftDeletes;
    protected $fillable = ['notification_title', 'notification_description', 'mother_data_id'];
    protected $dates = ['deleted_at'];

    public function mother_data()
    {
        return $this->belongsTo(MotherData::class);
    }
}
