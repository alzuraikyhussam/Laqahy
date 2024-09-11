<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Donor extends Model
{
    use HasFactory;
    protected $fillable = ['donor_name'];

    public function vaccine_stock_statement()
    {
        return $this->hasMany(VaccineStockStatement::class);
    }
}
