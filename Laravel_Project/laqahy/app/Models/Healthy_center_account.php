<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_center_account extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['healthy_center_id','device_name','MAC_address','join_date'];

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }
}
