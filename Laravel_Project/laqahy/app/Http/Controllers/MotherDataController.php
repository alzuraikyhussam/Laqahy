<?php

namespace App\Http\Controllers;

use App\Models\Mother_data;
use Exception;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class MotherDataController extends Controller
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
                    'mother_name' => 'required',
                    'mother_phone' => 'required',
                    'mother_identity_num' => 'required',
                    'mother_birthDate' => 'required',
                    'mother_village' => 'required',
                    'cities_id' => 'required',
                    'directorate_id' => 'required',
                    'healthy_center_id' => 'required',
                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $userExists = Mother_data::where('mother_name', $request->mother_name)->orWhere('mother_identity_num', $request->mother_identity_num)->exists();

            if ($userExists) {
                return response()->json([
                    'message' => 'This user already exists',
                ], 401);
            }

            // Create record
            $user = Mother_data::create([
                'mother_name' => $request->mother_name,
                'mother_phone' => $request->mother_phone,
                'mother_identity_num' => $request->mother_identity_num,
                'mother_birthDate' => $request->mother_birthDate,
                'mother_village' => $request->mother_village,
                'cities_id' => $request->cities_id,
                'directorate_id' => $request->directorate_id,
                'healthy_center_id' => $request->healthy_center_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'User created successfully',
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
