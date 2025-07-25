<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PermissionType extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['permission_type'];

    public function user()
    {
        return $this->hasMany(User::class);
    }
}
