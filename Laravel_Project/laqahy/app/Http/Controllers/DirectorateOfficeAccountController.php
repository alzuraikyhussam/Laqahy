<?php

namespace App\Http\Controllers;

use App\Models\DirectorateOfficeAccount;
use Exception;

class DirectorateOfficeAccountController extends Controller
{
    public function getHealthyCentersCount($directorate_office_account_id)
    {
        try {
            $centers = DirectorateOfficeAccount::withCount('healthy_center_account as healthy_centers_count')->where([['directorate_office_account_id', $directorate_office_account_id], ['healthy_center_account_phone', '!=', null]])->get();

            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $centers,
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getRegisteredHealthyCentersAccount($directorate_office_account_id)
    {
        try {
            $centers = DirectorateOfficeAccount::where([['directorate_office_account_id', $directorate_office_account_id], ['healthy_center_account_phone', '!=', null]])->get();

            return response()->json([
                'message' => 'Registered Centers retrieved successfully',
                'data' => $centers,
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
