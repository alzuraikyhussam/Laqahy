<?php

namespace App\Http\Controllers;

use App\Models\OrderState;
use Exception;

class OrderStateController extends Controller
{
    public function index()
    {
        try {
            $state = OrderState::get();
            return response()->json([
                'message' => 'Order States retrieved successfully',
                'data' => $state,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
