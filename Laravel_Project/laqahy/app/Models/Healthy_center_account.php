<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Healthy_center_account extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = ['healthy_center_id', 'device_name', 'device_username', 'MAC_address', 'joined_date'];

    public $timestamps = false;

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }
}
