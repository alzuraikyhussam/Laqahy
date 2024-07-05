<?php

namespace App\Http\Controllers;

use App\Models\Healthy_centers_stock_vaccine;
use App\Models\HealthyCenterOrder;
use App\Models\Order_state;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\Validator;

class HealthyCenterOrderController extends Controller
{
    public function centerAddOrder(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'vaccine_type_id' => 'required',
                    'healthy_center_id' => 'required',
                    'quantity' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $orderState = Order_state::where('order_state', 'صادرة')->first();

            $order = HealthyCenterOrder::create([
                'vaccine_type_id' => $request->vaccine_type_id,
                'healthy_center_id' => $request->healthy_center_id,
                'quantity' => $request->quantity,
                'center_note_data' => $request->center_note_data,
                'order_state_id' => $orderState->id,
            ]);

            return response()->json([
                'message' => 'Order created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }
    }

    public function centerOutgoingOrders($center_id)
    {
        try {
            $outgoing = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'صادرة'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
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

    public function centerInDeliveryOrders($center_id)
    {
        try {
            $inDelivery = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'قيد التسليم'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
            return response()->json([
                'message' => 'In delivery orders retrieved successfully',
                'data' => $inDelivery,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerDeliveredOrders($center_id)
    {
        try {
            $delivered = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'تم التسليم'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
            return response()->json([
                'message' => 'Delivered orders retrieved successfully',
                'data' => $delivered,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerRejectedOrders($center_id)
    {
        try {
            $rejected =  HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'مرفوضة'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
            return response()->json([
                'message' => 'Rejected orders retrieved successfully',
                'data' => $rejected,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerReceivingConfirmOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'healthy_center_id' => 'required',
                    'order_id' => 'required',
                ],
            );


            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $order = HealthyCenterOrder::find($request->order_id);

            $orderState = Order_state::where('order_state', 'تم التسليم')->first();

            $vaccine = Healthy_centers_stock_vaccine::where([['vaccine_type_id', $order->vaccine_type_id], ['healthy_center_id', $request->healthy_center_id]])->first();

            $updatedVaccineQty = $vaccine->quantity + $order->quantity;

            $vaccine->update([
                'quantity' => $updatedVaccineQty,
            ]);

            $order->update(['order_state_id' => $orderState->id, 'delivery_date' => Carbon::now()]);

            return response()->json([
                'message' => 'Order received successfully',
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
