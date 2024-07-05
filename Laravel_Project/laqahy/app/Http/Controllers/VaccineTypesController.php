<?php

namespace App\Http\Controllers;

use App\Models\Vaccine_type;
use Exception;
use Illuminate\Http\Request;

class VaccineTypesController extends Controller
{
    public function getVaccines()
    {
        try {
            $vaccines = Vaccine_type::get();
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
