<?php

namespace App\Http\Controllers;

use App\Models\MotherData;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotherDataController extends Controller
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
    public function index(string $healthyCenterId)
    {
        try {
            $mother = MotherData::get();
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

    public function getAllMotherStatusData()
    {
        try {
            $mother = MotherData::get();
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
                    'city_id' => 'required',
                    'directorate_id' => 'required',
                    'healthy_center_account_id' => 'required',
                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $motherDataExists = MotherData::where('mother_identity_num', $request->mother_identity_num)->exists();

            if ($motherDataExists) {
                return response()->json([
                    'message' => 'This identity number already exists',
                ], 401);
            }

            // Create record
            $mother = MotherData::create([
                'mother_name' => $request->mother_name,
                'mother_phone' => $request->mother_phone,
                'mother_identity_num' => $request->mother_identity_num,
                'mother_password' => $request->mother_password,
                'mother_birthDate' => $request->mother_birthDate,
                'mother_village' => $request->mother_village,
                'city_id' => $request->city_id,
                'directorate_id' => $request->directorate_id,
                'healthy_center_account_id' => $request->healthy_center_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Mother created successfully',
                'mother' => $mother,

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
    public function update(Request $request, string $motherId)
    {
        try {
            $updateMother = MotherData::find($motherId);

            if (!$updateMother) {
                return response()->json([
                    'message' => 'Mother not found',
                ], 404);
            }

            $motherDataExists = MotherData::where('mother_identity_num', $request->mother_identity_num)->exists();

            if ($request->mother_identity_num !== $updateMother->mother_identity_num) {
                $userExists = MotherData::where('mother_identity_num', $request->mother_identity_num)
                    ->exists();
                if ($userExists) {
                    return response()->json([
                        'message' => 'This identity number already exists',
                    ], 401);
                }
            }

            $updateMother->update($request->all());
            return response()->json([
                'message' => 'Mother updated successfully',
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
    public function destroy(string $motherId)
    {
        //
    }

    /////////////////////////// Ministry ///////////////////////////////////////

    public function getDateRange()
    {
        try {

            $minDate = Carbon::parse(MotherData::min('created_at'))->toDateString();
            $maxDate = Carbon::parse(MotherData::max('created_at'))->toDateString();

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

    public function directorateOfficeGetDateRange($directorateOfficeId)
    {
        try {

            $motherMinDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->min('mother_data.created_at');

            $motherMaxDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->max('mother_data.created_at');

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

    public function healthyCenterGetDateRange($healthyCenterId)
    {
        try {

            $motherMinDate = MotherData::where('mother_data.healthy_center_account_id', $healthyCenterId)->min('created_at');

            $motherMaxDate = MotherData::where('mother_data.healthy_center_account_id', $healthyCenterId)->max('created_at');

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

    public function showAllMothersStatusData(string $centerId)
    {
        try {
            $mother = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name')->get();
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
    public function printMotherStatusData(string $identityNumber)
    {
        try {
            $return_mother = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name')->where('mother_data.mother_identity_num', $identityNumber)->get();
            return response()->json([
                'message' => 'Mothers retrieved successfully',
                'data' => $return_mother,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
