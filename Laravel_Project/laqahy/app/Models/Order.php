<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Order extends Model
{
    use HasFactory, SoftDeletes;

    public $dates = ['deleted_at'];

    protected $fillable = ['vaccine_type', 'office_type_id', 'office_name', 'order_quantity', 'order_request_date', 'order_delivery_date', 'order_sender_note', 'order_receiver_note', 'order_state_id'];

    public function office_type()
    {
        return $this->belongsTo(OfficeType::class);
    }

    public function order_state()
    {
        return $this->belongsTo(OrderState::class);
    }

    public function office_name()
    {
        return $this->morphTo();
    }

    public function vaccine_type()
    {
        return $this->morphTo();
    }
}
