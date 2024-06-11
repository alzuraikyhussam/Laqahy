<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center;
use App\Models\Healthy_center_account;
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
                    'user_birthdate' => 'required',
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
                'user_birthdate' => $request->user_birthdate,
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

    public function login(Request $request)
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
}
