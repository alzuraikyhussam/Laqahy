<?php

namespace App\Http\Controllers;

use App\Models\Healthy_centers_stock_vaccine;
use App\Models\VaccineStock;
use Exception;

class HealthyCenterStockVaccineController extends Controller
{
    /**
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------- This Page Was Modified By Elias --------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    */
    public function index($center_id)
    {
        try {
            $vaccines = VaccineStock::join('vaccine_types', 'vaccine_stock.vaccine_type_id', '=', 'vaccine_types.id')->select('VaccineStock.*', 'vaccine_types.vaccine_type')->where('vaccine_stock.office_account_id', $center_id)->get();
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
