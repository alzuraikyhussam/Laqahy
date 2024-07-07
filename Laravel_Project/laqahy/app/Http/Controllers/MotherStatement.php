<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use App\Models\Mother_statement;
use Exception;
use Illuminate\Http\Request;

class MotherStatement extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $motherStatement = Mother_statement::get();
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
    public function show(string $id)
    {
        //
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
}
