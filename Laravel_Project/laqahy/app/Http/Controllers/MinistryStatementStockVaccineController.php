<?php

namespace App\Http\Controllers;

use App\Models\Ministry_statement_stock_vaccine;
use App\Models\Ministry_stock_vaccine;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MinistryStatementStockVaccineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
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
                    'vaccine_type_id' => 'required',
                    'quantity' => 'required',
                    'donor' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // Create record
            $addQty = Ministry_statement_stock_vaccine::create([
                'vaccine_type_id' => $request->vaccine_type_id,
                'quantity' => $request->quantity,
                'donor' => $request->donor,
            ]);

            $updateVaccineQty = Ministry_stock_vaccine::find($request->vaccine_type_id);
            $newQty = $updateVaccineQty->quantity + $request->quantity;
            $updateVaccineQty->update([
                'quantity' => $newQty,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Vaccine quantity created successfully',
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
