<?php

namespace App\Http\Controllers;

use App\Models\Mother_data;
use Exception;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Http\Request;

class MotherDataController extends Controller
{

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $mother = Mother_data::get();
            return response()->json([
                'message' => 'Mothers retrieved successfully',
                'data' => $mother,
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
                    'mother_name' => 'required',
                    'mother_phone' => 'required',
                    'mother_identity_num' => 'required',
                    'mother_password' => 'required',
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

            $motherDataExists = Mother_data::where('mother_name', $request->mother_name)->orWhere('mother_identity_num', $request->mother_identity_num)->exists();

            if ($motherDataExists) {
                return response()->json([
                    'message' => 'This mother already exists',
                ], 401);
            }

            // Create record
            $mother = Mother_data::create([
                'mother_name' => $request->mother_name,
                'mother_phone' => $request->mother_phone,
                'mother_identity_num' => $request->mother_identity_num,
                'mother_password' => $request->mother_password,
                'mother_birthDate' => $request->mother_birthDate,
                'mother_village' => $request->mother_village,
                'cities_id' => $request->cities_id,
                'directorate_id' => $request->directorate_id,
                'healthy_center_id' => $request->healthy_center_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Mother created successfully',
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

    /////////////////////////// Ministry ///////////////////////////////////////

    public function getDateRange()
    {
        try {

            $minDate = Carbon::parse(Mother_data::min('created_at'))->toDateString();
            $maxDate = Carbon::parse(Mother_data::max('created_at'))->toDateString();

            return response()->json([
                'message' => 'Date range retrieved successfully',
                'min_date' => $minDate,
                'max_date' => $maxDate,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /////////////////////////// Offices ////////////////////////////////

    public function officeGetDateRange($office_id)
    {
        try {

            $motherMinDate = Mother_data::join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->min('mother_data.created_at');

            $motherMaxDate = Mother_data::join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->max('mother_data.created_at');

            $minDate = Carbon::parse($motherMinDate)->toDateString();
            $maxDate = Carbon::parse($motherMaxDate)->toDateString();

            return response()->json([
                'message' => 'Date range retrieved successfully',
                'min_date' => $minDate,
                'max_date' => $maxDate,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    ////////////////////////////////// Centers //////////////////////////////////

    public function centerGetDateRange($center_id)
    {
        try {

            $motherMinDate = Mother_data::where('mother_data.healthy_center_id', $center_id)->min('created_at');

            $motherMaxDate = Mother_data::where('mother_data.healthy_center_id', $center_id)->max('created_at');

            $minDate = Carbon::parse($motherMinDate)->toDateString();
            $maxDate = Carbon::parse($motherMaxDate)->toDateString();

            return response()->json([
                'message' => 'Date range retrieved successfully',
                'min_date' => $minDate,
                'max_date' => $maxDate,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
