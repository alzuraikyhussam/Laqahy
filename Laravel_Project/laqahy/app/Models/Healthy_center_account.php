<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthy_center_account extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable=['healthy_centers_id','device_name','MAC_address','join_date'];


}
