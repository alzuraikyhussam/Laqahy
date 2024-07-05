<?php

namespace App\Http\Controllers;

use App\Models\Ministry_stock_vaccine;
use Exception;
use Illuminate\Http\Request;

class MinistryStockVaccineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $vaccine = Ministry_stock_vaccine::join('vaccine_types', 'ministry_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('ministry_stock_vaccines.*', 'vaccine_types.vaccine_type')->get();
            return response()->json([
                'message' => 'Vaccines retrieved successfully',
                'data' => $vaccine,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
