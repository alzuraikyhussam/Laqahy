<?php

namespace App\Http\Controllers;

use App\Models\Dosage_level;
use App\Models\Dosage_type;
use App\Models\Mother_statement;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotherStatementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'mother_data_id' => 'required',
                    'healthy_center_id' => 'required',
                    'user_id' => 'required',
                    'date_taking_dose' => 'required',
                    'return_date' => 'required',
                    'dosage_type_id' => 'required',
                    'dosage_level_id' => 'required',

                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $motherStatementExists = Mother_statement::where('dosage_level_id', $request->dosage_level_id)->exists();

            if ($motherStatementExists) {
                return response()->json([
                    'message' => 'لقد تم أخذ هذه الجرعة من قبل',
                ], 401);
            }

            // Create record
            $user = Mother_statement::create([
                'mother_data_id' => $request->mother_data_id,
                'healthy_center_id' => $request->healthy_center_id,
                'user_id' => $request->user_id,
                'date_taking_dose' => $request->date_taking_dose,
                'return_date' => $request->return_date,
                'dosage_type_id' => $request->dosage_type_id,
                'dosage_level_id' => $request->dosage_level_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Mother statement created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $center_id)
    {
        try {
            $motherStatement = Mother_statement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_statements.healthy_center_id', '=', 'healthy_centers.id')->join('dosage_types', 'mother_statements.dosage_type_id', '=', 'dosage_types.id')->join('dosage_levels', 'mother_statements.dosage_level_id', '=', 'dosage_levels.id')->join('users', 'mother_statements.user_id', '=', 'users.id')->select('mother_statements.*', 'mother_data.mother_name', 'healthy_centers.healthy_center_name', 'dosage_types.dosage_type', 'dosage_levels.dosage_level', 'users.user_name')->where('mother_statements.healthy_center_id', $center_id)->get();
            return response()->json([
                'message' => 'Mother statement retrieved successfully',
                'data' => $motherStatement,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


    public function getMotherStatements($mother_id)
    {

        try {
            $dosageCount = Dosage_level::withCount('dosage_type')->get();
            $basicDosageTakenCount = Mother_statement::where('mother_data_id', $mother_id)->where('dosage_level_id', 1)->count();
            $refresherDosageTakenCount = Mother_statement::where('mother_data_id', $mother_id)->where('dosage_level_id', 2)->count();

            return response()->json([
                'message' => 'Mother statements retrieved successfully',
                'data' => [
                    'dosage_count' => $dosageCount,
                    'basic_dosage_taken_count' => $basicDosageTakenCount,
                    'refresher_dosage_taken_count' => $refresherDosageTakenCount,
                ]
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
