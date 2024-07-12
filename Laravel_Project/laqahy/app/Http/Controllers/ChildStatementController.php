<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Child_statement;
use App\Models\Vaccine_type;
use App\Models\Vaccines_with_dosage;
use Exception;
use Illuminate\Http\Request;

class ChildStatementController extends Controller
{

    public function getChildVaccine($child_id)
    {

        try {
            $vaccineCount = Vaccine_type::withCount('child_dosage_type')->get();
            $childStatement = Child_statement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->select('child_statements.*', 'child_data.child_data_name')->where('child_statements.id', $child_id)->get();



            return response()->json([
                'message' => 'Mother dosage retrieved successfully',

                'data' => [
                    'vaccine_count' => $vaccineCount,
                    'child_statement' => $childStatement,
                ]
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
