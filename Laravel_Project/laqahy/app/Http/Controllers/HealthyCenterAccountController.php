<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center;
use App\Models\HealthyCenterAccount;
use Exception;
use function Laravel\Prompts\select;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HealthyCenterAccountController extends Controller
{
    /**
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
            $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->orderBy('healthy_center_accounts.id', 'asc')->get();

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

    public function getCentersByDirectorateOffice($id)
    {
        try {
            if ($id == 0) {
                $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->orderBy('healthy_center_accounts.id', 'asc')->get();
            } else {
                $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.directorate_office_account_id', $id)->orderBy('healthy_center_accounts.id', 'asc')->get();
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

    public function directorateOfficeGetCenters($directorate_office_account_id)
    {
        try {
            $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.directorate_office_account_id', $directorate_office_account_id)->orderBy('healthy_centers.id', 'asc')->get();

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

    public function directorateOfficeAddCenterAccount(Request $request, $directorate_office_account_id)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'healthy_center_account_name' => 'required',
                    'setup_code' => 'required',
                    'healthy_center_account_phone' => 'required',
                    'healthy_center_account_address' => 'required',
                    'directorate_office_account_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $centerExists = HealthyCenterAccount::where('directorate_office_account_id', $request->directorate_office_id)
                ->where(function ($query) use ($request) {
                    $query->where('healthy_center_account_name', $request->healthy_center_account_name);
                })->exists();

            if ($centerExists) {
                return response()->json([
                    'message' => 'This center already exists',
                ], 401);
            }

            // Create record
            $addCenter = HealthyCenterAccount::create([
                'healthy_center_account_name' => $request->healthy_center_account_name,
                'healthy_center_account_phone' => $request->healthy_center_account_phone,
                'healthy_center_account_address' => $request->healthy_center_account_address,
                'setup_code' => $request->setup_code,
                'directorate_office_account_id' => $directorate_office_account_id,
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

    public function directorateOfficeUpdateCenterAccount(Request $request, $directorate_office_account_id)
    {
        try {

            $center = HealthyCenterAccount::find($request->id);

            // التحقق من وجود اسم المركز في المكتب المحدد إذا تم تغييره
            if ($request->healthy_center_account_name !== $center->healthy_center_account_name) {
                $centerExists = HealthyCenterAccount::where('directorate_office_account_id', $directorate_office_account_id)
                    ->where('healthy_center_account_name', $request->healthy_center_account_name)
                    ->exists();
                if ($centerExists) {
                    return response()->json([
                        'message' => 'This name already exists',
                    ], 401);
                }
            }

            $center->update([
                'healthy_center_account_name' => $request->healthy_center_account_name,
                'healthy_center_account_phone' => $request->healthy_center_account_phone,
                'healthy_center_account_address' => $request->healthy_center_account_address,
                'directorate_office_account_id' => $directorate_office_account_id,
            ]);

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
