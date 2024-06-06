<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Order extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'vaccine_type_id',
        'healthy_center_id',
        'order_date',
        'quantity',
        'delivery_date',
        'healthy_center_note_date',
        'ministry_note_date',
        'order_state_id',
        'date_deleted_from_healthy_center',
        'date_deleted_from_ministry',
    ];

    protected $dates = ['deleted_at'];

    public function healthy_center()
    {
        return $this->belongsTo(Healthy_center::class);
    }

    public function vaccine_type()
    {
        return $this->belongsTo(Vaccine_type::class);
    }

    public function order_state()
    {
        return $this->belongsTo(Order_state::class);
    }
}
