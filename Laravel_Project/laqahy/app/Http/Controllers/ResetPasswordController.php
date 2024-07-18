<?php

namespace App\Http\Controllers;

use App\Models\Mother_data;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ResetPasswordController extends Controller
{
    public function mobileVerifyResetPassword(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'mother_identity_num' => 'required',
                    'mother_phone' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = Mother_data::where('mother_identity_num', $request->mother_identity_num)->where('mother_phone', $request->mother_identity_num)->first();

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

           

            $motherData = Mother_data::join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.id', $user->id)->first();

            return response()->json([
                'message' => 'Verified successfully',
                'user' => $motherData,
                
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

}
