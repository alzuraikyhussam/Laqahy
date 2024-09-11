<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use HasFactory;
    use SoftDeletes;
    public $timestamps = false;
    protected $fillable = ['post_title', 'post_description', 'post_image', 'post_publish_date', 'office_type_id', 'city_office_account_id'];
    protected $dates = ['deleted_at'];

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function city_office_account()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }
}
