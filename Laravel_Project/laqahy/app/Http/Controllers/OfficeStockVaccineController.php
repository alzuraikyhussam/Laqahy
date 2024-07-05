<?php

namespace App\Http\Controllers;

use App\Models\Office_stock_vaccine;
use Exception;
use Illuminate\Http\Request;

class OfficeStockVaccineController extends Controller
{
    public function getVaccines($office_id)
    {
        try {
            $vaccine = Office_stock_vaccine::join('vaccine_types', 'offices_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('offices_stock_vaccines.*', 'vaccine_types.vaccine_type')->where('offices_stock_vaccines.office_id', $office_id)->get();
            return response()->json([
                'message' => 'Vaccines retrieved successfully',
                'data' => $vaccine,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
