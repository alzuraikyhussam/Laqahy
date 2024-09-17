<?php

namespace App\Http\Controllers;

use App\Models\VaccineStock;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VaccineStockController extends Controller
{
    public function fetchVaccinesStock(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                    'vaccine_category' => 'required',
                ]
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $vaccineStock = VaccineStock::join($request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines' : 'child_vaccines', 'vaccine_stock.vaccine_type_id', '=', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.id' : 'child_vaccines.id')->select('vaccine_stock.*', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.mother_vaccine_type' : 'child_vaccines.child_vaccine_type')->where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->get();

            return response()->json([
                'message' => 'Vaccines stock retrieved successfully',
                'data' => $vaccineStock,
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
