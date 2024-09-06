<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ChildDataController extends Controller
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
                    'child_data_name' => 'required',
                    'child_data_birthDate' => 'required',
                    'child_data_birthplace' => 'required',
                    'mother_data_id' => 'required',
                    'gender_id' => 'required',
                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // $childDataExists = ChildData::where('child_data_name', $request->child_data_name)->exists();

            // if ($childDataExists) {
            //     return response()->json([
            //         'message' => 'This child already exists',
            //     ], 401);
            // }

            // Create record
            $child = ChildData::create([
                'child_data_name' => $request->child_data_name,
                'child_data_birthDate' => $request->child_data_birthDate,
                'child_data_birthplace' => $request->child_data_birthplace,
                'mother_data_id' => $request->mother_data_id,
                'gender_id' => $request->gender_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Child created successfully',
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

            $childData = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('genders', 'child_data.gender_id', '=', 'genders.id')->select('child_data.*', 'mother_data.mother_name', 'genders.genders_type')
                ->where('child_data.mother_data_id', $motherId)->get();

            // $motherData = MotherData::select('mother_data.id')->where('healthy_center_id', $healthyCenterId)->get();

            // $childData = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('genders', 'child_data.gender_id', '=', 'genders.id')->select('child_data.*', 'mother_data.mother_name', 'genders.genders_type')
            //     ->where('mother_data.id', $motherData)->get();

            return response()->json([
                'message' => 'Child Data retrieved successfully',
                'data' => $childData,
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
    public function update(Request $request, string $childId)
    {
        try {
            $updateChild = ChildData::find($childId);

            if (!$updateChild) {
                return response()->json([
                    'message' => 'Child not found',
                ], 404);
            }
            $updateChild->update($request->all());
            return response()->json([
                'message' => 'Child updated successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $childId)
    {
        //
    }

    public function getChildren($mother_id)
    {
        try {
            $childData = ChildData::where('mother_data_id', $mother_id)->get();
            return response()->json([
                'message' => 'Child Data retrieved successfully',
                'data' => $childData,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getAllChildrenStatusData()
    {
        try {
            $childData = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('genders', 'child_data.gender_id', '=', 'genders.id')->select('child_data.*', 'mother_data.mother_name', 'genders.genders_type')->get();
            return response()->json([
                'message' => 'Child Data retrieved successfully',
                'data' => $childData,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
