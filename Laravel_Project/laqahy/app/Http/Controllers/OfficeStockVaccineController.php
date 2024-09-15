<?php

namespace App\Http\Controllers;

use App\Models\Office_stock_vaccine;
use App\Models\VaccineStock;
use Exception;
use Illuminate\Http\Request;

class OfficeStockVaccineController extends Controller
{
    public function index($office_id)
    {
        try {
            $vaccines = VaccineStock::join('vaccine_types', 'vaccine_stock.vaccine_type_id', '=', 'vaccine_types.id')->select('vaccine_stock.*', 'vaccine_types.vaccine_type')->where('vaccine_stock.office_account_id', $office_id)->get();
            return response()->json([
                'message' => 'Vaccines quantity retrieved successfully',
                'data' => $vaccines,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
