<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'vaccine_types_id',
        'healthy_centers_id',
        'order_date',
        'quantity',
        'delivery_date',
        'healthy_center_note_date',
        'ministry_note_date',
        'order_states_id',
        'date_deleted_from_healthy_center',
        'date_deleted_from_ministry',
    ];
}
