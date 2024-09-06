<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Donor extends Model
{
    use HasFactory;
    protected $fillable = ['donor_name'];

    public function office_statement_stock_vaccine()
    {
        return $this->hasMany(VaccineStockStatement::class);
    }
}
