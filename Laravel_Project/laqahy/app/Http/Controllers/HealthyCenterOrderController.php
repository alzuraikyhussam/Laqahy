<?php

namespace App\Http\Controllers;

use App\Models\HealthyCenterOrder;
use Exception;
use Illuminate\Http\Request;

class HealthyCenterOrderController extends Controller
{
    public function outgoingOrders($center_id)
    {
        try {
            $outgoing = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'صادرة'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('updated_at', 'desc')->get();
            return response()->json([
                'message' => 'Outgoing orders retrieved successfully',
                'data' => $outgoing,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
