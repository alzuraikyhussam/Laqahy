<?php

namespace App\Http\Controllers;

use App\Models\DosageLevel;
use App\Models\MotherStatement;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotherStatementController extends Controller
{
    /*
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------- This Page Was Modified By Elias --------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
    **--------------------------------------------------------------
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
                    'healthy_center_account_id' => 'required',
                    'user_id' => 'required',
                    'date_taking_dose' => 'required',
                    'return_date' => 'required',
                    'mother_vaccine_id' => 'required',
                    'mother_dosage_type_id' => 'required',
                    'dosage_level_id' => 'required',
                ],
            );

            // if ($validator->fails()) {
            //     return response()->json([
            //         'message' => $validator->errors(),
            //     ], 400);
            // }

            // $vaccineQty = Healthy_centers_stock_vaccine::where([['healthy_center_id', $request->healthy_center_id], ['vaccine_type_id', $request->vaccine_type_id]])->first();
            // $qty = 1;

            // if ($qty > $vaccineQty->quantity) {
            //     return response()->json([
            //         'message' => 'Vaccine quantity not enough',
            //         'quantity' => $vaccineQty->quantity,
            //     ], 405);
            // }

            $motherStatementExists = MotherStatement::where('mother_dosage_type_id', $request->mother_dosage_type_id)->where('mother_data_id', $request->mother_data_id)->exists();

            if ($motherStatementExists) {
                return response()->json([
                    'message' => 'لقد تم أخذ هذه الجرعة من قبل',
                ], 401);
            }

            // Create record
            $user = MotherStatement::create([
                'mother_data_id' => $request->mother_data_id,
                'healthy_center_account_id' => $request->healthy_center_account_id,
                'user_id' => $request->user_id,
                'date_taking_dose' => $request->date_taking_dose,
                'return_date' => $request->return_date,
                'mother_vaccine_id' => $request->mother_vaccine_id,
                'mother_dosage_type_id' => $request->mother_dosage_type_id,
                'dosage_level_id' => $request->dosage_level_id,
            ]);

            // $oldQty = $vaccineQty->quantity;
            // $newQty = $oldQty - $qty;
            // $vaccineQty->update(['quantity' => $newQty]);

            // Return created record
            return response()->json([
                'message' => 'Mother statement created successfully',
                // 'quantity' => $vaccineQty->quantity,
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
    public function show(string $motherId)
    {
        try {

            $motherStatement = MotherStatement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('mother_dosage_types', 'mother_statements.mother_dosage_type_id', '=', 'mother_dosage_types.id')->join('dosage_levels', 'mother_statements.dosage_level_id', '=', 'dosage_levels.id')->join('users', 'mother_statements.user_id', '=', 'users.id')->select('mother_statements.*', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'mother_dosage_types.mother_dosage_type', 'dosage_levels.dosage_level', 'users.user_name')->where('mother_statements.mother_data_id', $motherId)->get();

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
    public function destroy(string $motherId)
    {

        try {
            $motherDeleteStatement = MotherStatement::find($motherId);
            if (!$motherDeleteStatement) {
                return response()->json([
                    'message' => 'Mother Data not found',
                ], 404);
            }

            $motherDeleteStatement->delete();

            return response()->json([
                'message' => 'Mother Statement Data deleted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getMotherDosage(string $mother_id)
    {
        try {
            $dosageCount = DosageLevel::withCount('mother_dosage_types')->get();
            $basicDosageTakenCount = MotherStatement::where('mother_data_id', $mother_id)->where('dosage_level_id', 1)->count();
            $refresherDosageTakenCount = MotherStatement::where('mother_data_id', $mother_id)->where('dosage_level_id', 2)->count();

            return response()->json([
                'message' => 'Mother dosage retrieved successfully',
                'data' => [
                    'dosage_count' => $dosageCount,
                    'basic_dosage_taken_count' => $basicDosageTakenCount,
                    'refresher_dosage_taken_count' => $refresherDosageTakenCount,
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function printMotherStatementData(string $motherId, string $dosageLevel, string $dosageType)
    {
        try {
            $motherStatement = MotherStatement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('mother_dosage_types', 'mother_statements.mother_dosage_type_id', '=', 'mother_dosage_types.id')->join('dosage_levels', 'mother_statements.dosage_level_id', '=', 'dosage_levels.id')->join('users', 'mother_statements.user_id', '=', 'users.id')->select('mother_statements.*', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'mother_dosage_types.mother_dosage_type', 'dosage_levels.dosage_level', 'users.user_name')->where('mother_statements.dosage_level_id', $dosageLevel)->where('mother_statements.mother_dosage_type_id', $dosageType)->where('mother_statements.mother_data_id', $motherId)->get();

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
}
