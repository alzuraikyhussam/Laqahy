<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center;
use Exception;
use function Laravel\Prompts\select;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HealthyCenterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.city_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->orderBy('healthy_centers.id', 'asc')->get();

            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $center,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getCentersByOffice($id)
    {
        try {
            if ($id == 0) {
                $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.city_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->orderBy('healthy_centers.id', 'asc')->get();
            } else {
                $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.city_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->where('healthy_centers.office_id', $id)->orderBy('healthy_centers.id', 'asc')->get();
            }
            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $center,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /////////////////////////////////////// Offices //////////////////////////////////////////

    public function officeGetCenters($office_id)
    {
        try {
            $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.city_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->where('healthy_centers.office_id', $office_id)->orderBy('healthy_centers.id', 'asc')->get();

            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $center,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeAddCenterAccount(Request $request, $office_id)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'healthy_center_name' => 'required',
                    'healthy_center_phone' => 'required',
                    'healthy_center_address' => 'required',
                    'city_id' => 'required',
                    'directorate_id' => 'required',
                    'create_account_code' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $centerExists = Healthy_center::where('office_id', $request->office_id)
                ->where(function ($query) use ($request) {
                    $query->where('healthy_center_name', $request->healthy_center_name);
                })->exists();

            if ($centerExists) {
                return response()->json([
                    'message' => 'This center already exists',
                ], 401);
            }

            // Create record
            $addCenter = Healthy_center::create([
                'healthy_center_name' => $request->healthy_center_name,
                'healthy_center_phone' => $request->healthy_center_phone,
                'healthy_center_address' => $request->healthy_center_address,
                'city_id' => $request->city_id,
                'directorate_id' => $request->directorate_id,
                'create_account_code' => $request->create_account_code,
                'office_id' => $office_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Center created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }
    }

    public function officeUpdateCenterAccount(Request $request, $office_id)
    {
        try {

            $center = Healthy_center::find($request->id);

            // التحقق من وجود اسم المركز في المكتب المحدد إذا تم تغييره
            if ($request->healthy_center_name !== $center->healthy_center_name) {
                $centerExists = Healthy_center::where('office_id', $office_id)
                    ->where('healthy_center_name', $request->healthy_center_name)
                    ->exists();
                if ($centerExists) {
                    return response()->json([
                        'message' => 'This name already exists',
                    ], 401);
                }
            }

            $center->update(['healthy_center_name' => $request->healthy_center_name, 'healthy_center_phone' => $request->healthy_center_phone, 'healthy_center_address' => $request->healthy_center_address, 'city_id' => $request->city_id, 'directorate_id' => $request->directorate_id]);

            return response()->json([
                'message' => 'Center updated successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
