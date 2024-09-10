<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Circulars extends Model
{
    use HasFactory;

    protected $fillable = ['circular_title', 'circular_description', 'circular_date', 'send_type_id', 'office_type_id', 'sen_office_id', 'rec_office_id'];

    public function send_type()
    {
        return $this->belongsTo(SendType::class);
    }

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function city_office_account_sen_office_name()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function directorate_office_account_sen_office_name()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }

    public function city_office_account_rec_office_name()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function directorate_office_account_rec_office_name()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }
}
