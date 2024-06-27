<?php

namespace App\Http\Controllers;

use App\Models\Order_state;
use Exception;
use Illuminate\Http\Request;

class OrderStateController extends Controller
{
    public function index()
    {
        try {
            $state = Order_state::get();
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
