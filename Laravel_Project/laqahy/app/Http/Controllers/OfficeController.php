<?php

namespace App\Http\Controllers;

use App\Models\CityOfficeAccount;
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
                    'city_office_account_phone' => 'required',
                    'city_office_account_address' => 'required',
                ],
            );

            $office = CityOfficeAccount::find($id);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            if ($request->setup_code == null) {
                $office->update(['city_office_account_phone' => $request->city_office_account_phone, 'city_office_account_address' => $request->city_office_account_address,  'updated_at' => Carbon::now(),]);
                return response()->json([
                    'message' => 'City office updated successfully',
                ], 200);
            } else {
                $office->update(['city_office_account_phone' => $request->city_office_account_phone, 'setup_code' => $request->setup_code, 'city_office_account_address' => $request->city_office_account_address, 'updated_at' => Carbon::now(), 'created_at' => Carbon::now(),]);
                return response()->json([
                    'message' => 'City office initialized successfully',
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
            $office = CityOfficeAccount::withCount('healthyCenter as healthy_centers_count')->where([['city_office_account_phone', '!=', null], ['city_office_account_name', '!=', 'وزارة الصحة والسكان']])->get();

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
            $office = CityOfficeAccount::where([['city_office_account_phone', '!=', null], ['city_office_account_name', '!=', 'وزارة الصحة والسكان']])->get();

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
            $office = CityOfficeAccount::where([['city_office_account_phone', null], ['city_office_account_name', '!=', 'وزارة الصحة والسكان']])->get();

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
