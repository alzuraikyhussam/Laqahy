<?php

namespace App\Http\Controllers;

use App\Models\Office;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OfficeController extends Controller
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
    public function update(Request $request, $id)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'office_phone' => 'required',
                    'office_address' => 'required',
                ],
            );

            $office = Office::find($id);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            if ($request->create_account_code == null) {
                $office->update(['office_phone' => $request->office_phone, 'office_address' => $request->office_address,  'updated_at' => Carbon::now(),]);
                return response()->json([
                    'message' => 'Office updated successfully',
                ], 200);
            } else {
                $office->update(['office_phone' => $request->office_phone, 'create_account_code' => $request->create_account_code, 'office_address' => $request->office_address, 'updated_at' => Carbon::now(), 'created_at' => Carbon::now(),]);
                return response()->json([
                    'message' => 'Office initialized successfully',
                ], 200);
            }
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function getCentersCount()
    {
        try {
            $office = Office::withCount('healthyCenter as healthy_centers_count')->where([['office_phone', '!=', null], ['office_name', '!=', 'وزارة الصحة والسكان']])->get();

            return response()->json([
                'message' => 'Offices retrieved successfully',
                'data' => $office,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getRegisteredOffices()
    {
        try {
            $office = Office::where([['office_phone', '!=', null], ['office_name', '!=', 'وزارة الصحة والسكان']])->get();

            return response()->json([
                'message' => 'Registered offices retrieved successfully',
                'data' => $office,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getUnRegisteredOffices()
    {
        try {
            $office = Office::where([['office_phone', null], ['office_name', '!=', 'وزارة الصحة والسكان']])->get();

            return response()->json([
                'message' => 'Unregistered offices retrieved successfully',
                'data' => $office,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
