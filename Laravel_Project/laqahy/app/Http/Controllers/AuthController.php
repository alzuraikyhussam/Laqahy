<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center;
use App\Models\Healthy_center_account;
use App\Models\Mother_data;
use App\Models\Office;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
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
                    'healthy_center_name' => 'required',
                    'healthy_center_address' => 'required',
                    'healthy_center_phone' => 'required',
                    'directorate_id' => 'required',
                    'cities_id' => 'required',
                    // 'device_name' => 'required',
                    // 'device_username' => 'required',
                    // 'MAC_address' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = User::where('user_account_name', $request->user_account_name)->orWhere('user_name', $request->user_name)->exists();
            $office = Office::where('office_name', 'مكتب الصحة والسكان - عدن')->first();

            if ($user) {
                return response()->json([
                    'message' => 'This user already exists',
                ], 401);
            }

            $center = Healthy_center::create([
                'healthy_center_name' => $request->healthy_center_name,
                'healthy_center_address' => $request->healthy_center_address,
                'healthy_center_phone' => $request->healthy_center_phone,
                'directorate_id' => $request->directorate_id,
                'cities_id' => $request->cities_id,
                'office_id' => $office->id,
            ]);

            // $centerAccount = Healthy_center_account::create([
            //     'healthy_center_id' => $center->id,
            //     'device_name' => $request->device_name,
            //     'device_username' => $request->device_username,
            //     'MAC_address' => $request->MAC_address,
            // ]);

            $user = User::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'healthy_center_id' => $center->id,
            ]);

            return response()->json([
                'message' => 'Healthy center account with admin account are created successfully',
                'user' => $user,
                'center' => $center,
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function login(Request $request, $centerId = null)
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

            if ($centerId != null) {
                if ($centerId != $user->healthy_center_id) {
                    return response()->json([
                        'message' => 'User not found in this healthy center',
                    ], 402);
                }
            }

            if (!($request->user_account_password === $user->user_account_password)) {
                return response()->json([
                    'message' => 'Invalid password',
                ], 401);
            }


            Auth::login($user);
            $center = Healthy_center::where('id', $user->healthy_center_id)->first();
            return response()->json([
                'message' => 'Login successfully',
                'user' => $user,
                'center' => $center,
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


            Auth::login($user);
            $motherData = Mother_data::join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.id', $user->id)->first();

            return response()->json([
                'message' => 'Login successfully',
                'user' => $motherData,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
