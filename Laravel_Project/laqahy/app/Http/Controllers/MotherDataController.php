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
    public function index()
    {
        try {
            $mother = MotherData::get();

            return response()->json([
                'message' => 'Mothers data retrieved successfully',
                'data' => $mother,
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // public function getAllMothersStatusData()
    // {
    //     try {
    //         $mother = MotherData::get();

    //         return response()->json([
    //             'message' => 'Mothers data retrieved successfully',
    //             'data' => $mother,
    //         ]);

    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

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
                'healthy_center_account_id' => $request->healthy_center_account_id,
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
     * Update the specified resource in storage.
     */
    public function update(Request $request, $motherId)
    {
        try {
            $updateMother = MotherData::find($motherId);

            if (!$updateMother) {
                return response()->json([
                    'message' => 'Mother not found',
                ], 404);
            }

            if ($request->mother_identity_num !== $updateMother->mother_identity_num) {
                $motherExists = MotherData::where('mother_identity_num', $request->mother_identity_num)
                    ->exists();

                if ($motherExists) {
                    return response()->json([
                        'message' => 'This identity number already exists',
                    ], 401);
                }
            }

            $updateMother->update($request->all());
            return response()->json([
                'message' => 'Mother data updated successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getDateRange(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                ]
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $minDate = null;
            $maxDate = null;

            if ($request->office_type_id == 1) { // وزارة

                $minDate = Carbon::parse(MotherData::min('created_at'))->toDateString();
                $maxDate = Carbon::parse(MotherData::max('created_at'))->toDateString();

            } else if ($request->office_type_id == 3) { // مكتب مديرية

                $validator = Validator::make(
                    $request->all(),
                    [
                        'directorate_office_account_id' => 'required',
                    ]
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $motherMinDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $request->directorate_office_account_id)->min('mother_data.created_at');

                $motherMaxDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $request->directorate_office_account_id)->max('mother_data.created_at');

                $minDate = Carbon::parse($motherMinDate)->toDateString();
                $maxDate = Carbon::parse($motherMaxDate)->toDateString();

            } else if ($request->office_type_id == 4) { // مركز صحي

                $validator = Validator::make(
                    $request->all(),
                    [
                        'healthy_center_account_id' => 'required',
                    ]
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $motherMinDate = MotherData::where('mother_data.healthy_center_account_id', $request->healthy_center_account_id)->min('created_at');
                $motherMaxDate = MotherData::where('mother_data.healthy_center_account_id', $$request->healthy_center_account_id)->max('created_at');

                $minDate = Carbon::parse($motherMinDate)->toDateString();
                $maxDate = Carbon::parse($motherMaxDate)->toDateString();

            }

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

    // public function directorateOfficeGetDateRange($directorateOfficeId)
    // {
    //     try {

    //         $motherMinDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->min('mother_data.created_at');

    //         $motherMaxDate = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->max('mother_data.created_at');

    //         $minDate = Carbon::parse($motherMinDate)->toDateString();
    //         $maxDate = Carbon::parse($motherMaxDate)->toDateString();

    //         return response()->json([
    //             'message' => 'Date range retrieved successfully',
    //             'min_date' => $minDate,
    //             'max_date' => $maxDate,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    ////////////////////////////////// Centers //////////////////////////////////

    // public function healthyCenterGetDateRange($healthyCenterId)
    // {
    //     try {

    //         $motherMinDate = MotherData::where('mother_data.healthy_center_account_id', $healthyCenterId)->min('created_at');

    //         $motherMaxDate = MotherData::where('mother_data.healthy_center_account_id', $healthyCenterId)->max('created_at');

    //         $minDate = Carbon::parse($motherMinDate)->toDateString();
    //         $maxDate = Carbon::parse($motherMaxDate)->toDateString();

    //         return response()->json([
    //             'message' => 'Date range retrieved successfully',
    //             'min_date' => $minDate,
    //             'max_date' => $maxDate,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    public function getAllMothersStatusData()
    {
        try {
            $mother = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'healthy_center_accounts.healthy_center_account_name', 'cities.city_name', 'directorates.directorate_name')->get();

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
            $mother = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name')->where('mother_data.mother_identity_num', $identityNumber)->get();

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
}
