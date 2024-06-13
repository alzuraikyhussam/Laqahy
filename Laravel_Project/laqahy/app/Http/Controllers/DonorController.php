<?php

namespace App\Http\Controllers;

use App\Models\Donor;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DonorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $donor = Donor::get();
            return response()->json([
                'message' => 'Donors retrieved successfully',
                'data' => $donor,
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
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'donor_name' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $isDonorExists = Donor::where('donor_name', $request->donor_name)->exists();

            if ($isDonorExists) {
                return response()->json([
                    'message' => 'This Donor already exists',
                ], 401);
            }

            // Create record
            $donor = Donor::create([
                'donor_name' => $request->donor_name,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Donor created successfully',
                'data' => $donor,
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
