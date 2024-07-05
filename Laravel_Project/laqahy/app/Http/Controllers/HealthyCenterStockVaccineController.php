<?php

namespace App\Http\Controllers;

use App\Models\Healthy_centers_stock_vaccine;
use Exception;
use Illuminate\Http\Request;

class HealthyCenterStockVaccineController extends Controller
{
    public function index($center_id)
    {
        try {
            $vaccines = Healthy_centers_stock_vaccine::join('vaccine_types', 'healthy_centers_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('healthy_centers_stock_vaccines.*', 'vaccine_types.vaccine_type')->where('healthy_centers_stock_vaccines.healthy_center_id', $center_id)->get();
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
