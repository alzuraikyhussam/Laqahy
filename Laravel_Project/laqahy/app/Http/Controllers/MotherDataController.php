<?php

namespace App\Http\Controllers;

use App\Models\Mother_data;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;

class MotherDataController extends Controller
{

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
}
