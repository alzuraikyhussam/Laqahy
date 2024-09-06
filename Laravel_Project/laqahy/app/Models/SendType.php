<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SendType extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['send_type'];

    public function circulars()
    {
        return $this->hasOne(Circulars::class);
    }
}
