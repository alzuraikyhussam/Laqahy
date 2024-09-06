<?php

namespace App\Http\Controllers;

use App\Models\VaccineType;
use Exception;

class VaccineTypesController extends Controller
{
    public function getVaccines()
    {
        try {
            $vaccines = VaccineType::get();
            return response()->json([
                'message' => 'Vaccines retrieved successfully',
                'data' => $vaccines,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
