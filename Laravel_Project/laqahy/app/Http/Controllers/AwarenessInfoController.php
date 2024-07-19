<?php

namespace App\Http\Controllers;

use App\Models\AwarenessInfo;
use Exception;
use Illuminate\Http\Request;

class AwarenessInfoController extends Controller
{
    public function index()
    {
        try {
            $awareness = AwarenessInfo::get();

            return response()->json([
                'message' => 'Awareness information retrieved successfully',
                'data' => $awareness,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
