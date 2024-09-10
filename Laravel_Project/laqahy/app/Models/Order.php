<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Order extends Model
{
    use HasFactory, SoftDeletes;

    public $dates = ['deleted_at'];

    protected $fillable = ['vaccine_type_id', 'office_type_id', 'office_account_id', 'order_quantity', 'order_request_date', 'order_delivery_date', 'order_sender_note', 'order_receiver_note', 'order_state_id', 'vaccine_category'];

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function order_state()
    {
        return $this->belongsTo(OrderState::class);
    }

    public function city_office_account()
    {
        return $this->belongsTo(CityOfficeAccount::class);
    }

    public function directorate_office_account()
    {
        return $this->belongsTo(DirectorateOfficeAccount::class);
    }

    public function healthy_center_account()
    {
        return $this->belongsTo(HealthyCenterAccount::class);
    }

    public function mother_vaccine()
    {
        return $this->belongsTo(MotherVaccine::class);
    }

    public function child_vaccine()
    {
        return $this->belongsTo(ChildVaccine::class);
    }
}
