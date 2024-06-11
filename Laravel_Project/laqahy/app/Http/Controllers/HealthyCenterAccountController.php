<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center_account;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HealthyCenterAccountController extends Controller
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
        // try {
        //     $validator = Validator::make(
        //         $request->all(),
        //         [
        //             'healthy_center_id ' => 'required',
        //             'device_name' => 'required',
        //             'device_username' => 'required',
        //             'MAC_address' => 'required',
        //         ],
        //     );

        //     if ($validator->fails()) {
        //         return response()->json([
        //             'message' => $validator->errors(),
        //         ], 400);
        //     }

        //     // Create record
        //     $centerAccount = Healthy_center_account::create([
        //         'healthy_center_id' => $request->healthy_center_id,
        //         'device_name' => $request->device_name,
        //         'device_username' => $request->device_username,
        //         'MAC_address' => $request->MAC_address,
        //     ]);

        //     // Return created record
        //     return response()->json([
        //         'message' => 'Healthy Center Account created successfully',
        //         'data' => $centerAccount,
        //     ], 201);
        // } catch (Exception $e) {
        //     return response()->json([
        //         'message' => $e->getMessage(),
        //     ], 500);
        // }
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
