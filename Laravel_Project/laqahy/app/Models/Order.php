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
        'office_id',
        'order_date',
        'quantity',
        'delivery_date',
        'office_note_data',
        'ministry_note_data',
        'order_state_id',
    ];

    protected $dates = ['deleted_at'];

    public function office()
    {
        return $this->belongsTo(Office::class);
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
