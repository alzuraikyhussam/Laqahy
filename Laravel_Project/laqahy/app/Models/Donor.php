<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Donor extends Model
{
    use HasFactory;
    protected $fillable = ['donor_name'];

    public function ministryStatementStockVaccines()
    {
        return $this->hasMany(Ministry_statement_stock_vaccine::class);
    }
}
