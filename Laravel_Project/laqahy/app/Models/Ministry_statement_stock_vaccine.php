<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ministry_statement_stock_vaccine extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'vaccine_types_id',
        'quantity',
        'donor',
        'date',
    ];
}
