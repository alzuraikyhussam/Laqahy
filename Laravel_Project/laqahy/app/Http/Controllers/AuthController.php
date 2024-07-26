<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Healthy_center;
use App\Models\Healthy_center_account;
use App\Models\Healthy_centers_stock_vaccine;
use App\Models\Ministry_stock_vaccine;
use App\Models\Mother_data;
use App\Models\Mother_statement;
use App\Models\Office;
use App\Models\Office_stock_vaccine;
use App\Models\Offices_users;
use App\Models\User;
use App\Models\Vaccine_type;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'user_name' => 'required',
                    'user_phone' => 'required',
                    'user_address' => 'required',
                    'user_birthDate' => 'required',
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                    'gender_id' => 'required',
                    'permission_type_id' => 'required',
                    'office_name' => 'required',
                    'office_phone' => 'required',
                    'office_address' => 'required',
                    'cities_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $office = Office::create([
                'office_name' => $request->office_name,
                'office_address' => $request->office_address,
                'office_phone' => $request->office_phone,
                'cities_id' => $request->cities_id,
            ]);

            $user = Offices_users::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'office_id' => $office->id,
            ]);

            $vaccines = Vaccine_type::all();

            foreach ($vaccines as $vaccine) {
                Ministry_stock_vaccine::create([
                    'vaccine_type_id' => $vaccine->id,
                    'quantity' => 0,
                ]);
            }

            return response()->json([
                'message' => 'Office account with admin account are created successfully',
                'user' => $user,
                'office' => $office,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    ///////////////////Offices//////////////////////

    public function login(Request $request, $office_id = 0)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = Offices_users::where('user_account_name', $request->user_account_name)->first();

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            if ($office_id != 0) {
                if ($office_id != $user->office_id) {
                    return response()->json([
                        'message' => 'User not found in this office',
                    ], 402);
                }
            }

            if (!($request->user_account_password === $user->user_account_password)) {
                return response()->json([
                    'message' => 'Invalid password',
                ], 401);
            }

            $admin = Offices_users::where([
                ['permission_type_id', 1],
                ['office_id', $user->office_id]
            ])->first();

            $office = Office::where('id', $user->office_id)->first();
            return response()->json([
                'message' => 'Login successfully',
                'user' => $user,
                'office' => $office,
                'admin' => $admin,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeCheckVerificationCode($code)
    {
        try {

            $office = Office::where('create_account_code', $code)->first();

            if (!$office) {
                return response()->json([
                    'message' => 'Office not found',
                ], 404);
            }

            return response()->json([
                'message' => 'Office retrieved successfully',
                'office' => $office,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeRegister(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'user_name' => 'required',
                    'user_phone' => 'required',
                    'user_address' => 'required',
                    'user_birthDate' => 'required',
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                    'gender_id' => 'required',
                    'permission_type_id' => 'required',
                    'office_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $office = Office::where('id', $request->office_id)->first();

            $user = Offices_users::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'office_id' => $request->office_id,
            ]);

            $office->update(['create_account_code' => null]);

            $vaccines = Vaccine_type::all();

            foreach ($vaccines as $vaccine) {
                Office_stock_vaccine::create([
                    'office_id' => $office->id,
                    'vaccine_type_id' => $vaccine->id,
                    'quantity' => 0,
                ]);
            }

            return response()->json([
                'message' => 'Office account with admin account are created successfully',
                'user' => $user,
                'office' => $office,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /////////////////////////////// Centers ////////////////////////////////

    public function centerCheckVerificationCode($code)
    {
        try {

            $center = Healthy_center::where('create_account_code', $code)->first();

            if (!$center) {
                return response()->json([
                    'message' => 'Center not found',
                ], 404);
            }

            return response()->json([
                'message' => 'Center retrieved successfully',
                'center' => $center,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerRegister(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'user_name' => 'required',
                    'user_phone' => 'required',
                    'user_address' => 'required',
                    'user_birthDate' => 'required',
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                    'gender_id' => 'required',
                    'permission_type_id' => 'required',
                    'healthy_center_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $center = Healthy_center::join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'offices.office_name')->where('healthy_centers.id', $request->healthy_center_id)->first();

            $user = User::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'healthy_center_id' => $request->healthy_center_id,
            ]);

            $center->update(['create_account_code' => null]);

            $vaccines = Vaccine_type::all();

            foreach ($vaccines as $vaccine) {
                Healthy_centers_stock_vaccine::create([
                    'healthy_center_id' => $center->id,
                    'vaccine_type_id' => $vaccine->id,
                    'quantity' => 0,
                ]);
            }

            return response()->json([
                'message' => 'Center account with admin account are created successfully',
                'user' => $user,
                'center' => $center,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerLogin(Request $request, $center_id = 0)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = User::where('user_account_name', $request->user_account_name)->first();

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            if ($center_id != 0) {
                if ($center_id != $user->healthy_center_id) {
                    return response()->json([
                        'message' => 'User not found in this center',
                    ], 402);
                }
            }

            if (!($request->user_account_password === $user->user_account_password)) {
                return response()->json([
                    'message' => 'Invalid password',
                ], 401);
            }

            $admin = User::where([
                ['permission_type_id', 1],
                ['healthy_center_id', $user->healthy_center_id]
            ])->first();


            $center = Healthy_center::join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'offices.office_name')->where('healthy_centers.id', $user->healthy_center_id)->first();

            return response()->json([
                'message' => 'Login successfully',
                'user' => $user,
                'center' => $center,
                'admin' => $admin,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    ///////////////////MOBILE//////////////////////

    public function mobileLogin(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'mother_identity_num' => 'required',
                    'mother_password' => 'required',
                    'token' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = Mother_data::where('mother_identity_num', $request->mother_identity_num)->first();

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            if (!($request->mother_password === $user->mother_password)) {
                return response()->json([
                    'message' => 'Invalid password',
                ], 401);
            }

            $motherData = Mother_data::join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.id', $user->id)->first();

            $returnDate = Mother_statement::where('mother_data_id', $motherData->id)->max('return_date');
            $childrenCount = Child_data::where('mother_data_id', $motherData->id)->count();

            // Set token
            $user->fcm_token = $request->token;
            $user->save();

            // $children = Child_data::where('mother_data_id', $user->id)->get();

            // foreach ($children as $child) {
            //     $child->fcm_token = $request->token;
            //     $child->save();
            // }
            // ---------

            return response()->json([
                'message' => 'Login successfully',
                'user' => $motherData,
                'return_date' => $returnDate,
                'children_count' => $childrenCount,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function mobileLoginWithFingerprint(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'mother_id' => 'required',
                    'token' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = Mother_data::find($request->mother_id);

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            $motherData = Mother_data::join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.id', $user->id)->first();

            $returnDate = Mother_statement::where('mother_data_id', $motherData->id)->max('return_date');
            $childrenCount = Child_data::where('mother_data_id', $motherData->id)->count();

            // Set token
            $user->fcm_token = $request->token;
            $user->save();

            return response()->json([
                'message' => 'Login successfully',
                'user' => $motherData,
                'return_date' => $returnDate,
                'children_count' => $childrenCount,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
