<?php

namespace App\Http\Controllers;

use App\Models\Notifications;
use Exception;

class NotificationsController extends Controller
{
    public function show($mother_id)
    {
        try {
            $notification = Notifications::where('mother_data_id', $mother_id)->orderBy('created_at', 'desc')->get();

            return response()->json([
                'message' => 'Notifications retrieved successfully',
                'data' => $notification,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
