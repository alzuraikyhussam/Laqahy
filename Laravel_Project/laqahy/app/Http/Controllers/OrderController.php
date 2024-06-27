<?php

namespace App\Http\Controllers;

use App\Models\Ministry_stock_vaccine;
use App\Models\Order;
use App\Models\Order_state;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function incomingOrders()
    {
        try {
            $incoming = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'orders.office_id', '=', 'offices.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'صادرة')->orderBy('updated_at', 'desc')->get();
            return response()->json([
                'message' => 'Incoming orders retrieved successfully',
                'data' => $incoming,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function inDeliveryOrders()
    {
        try {
            $inDelivery = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'orders.office_id', '=', 'offices.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'قيد التسليم')->orderBy('updated_at', 'desc')->get();
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

    public function deliveredOrders()
    {
        try {
            $delivered = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'orders.office_id', '=', 'offices.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'تم التسليم')->orderBy('updated_at', 'desc')->get();
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

    public function cancelledOrders()
    {
        try {
            $cancelled = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'orders.office_id', '=', 'offices.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'مرفوضة')->orderBy('updated_at', 'desc')->get();
            return response()->json([
                'message' => 'Cancelled orders retrieved successfully',
                'data' => $cancelled,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function transferToInDelivery(Request $request, $id)
    {
        try {
            $order = Order::find($id);
            $vaccineQty = Ministry_stock_vaccine::where('vaccine_type_id', $order->vaccine_type_id)->first();
            $orderState = Order_state::where('order_state', 'قيد التسليم')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            if ($request->quantity > $vaccineQty->quantity) {
                return response()->json([
                    'message' => 'Vaccine quantity not enough',
                    'quantity' => $vaccineQty->quantity,
                ], 401);
            }

            $oldQty = $vaccineQty->quantity;
            $newQty = $oldQty - $request->quantity;

            $vaccineQty->update(['quantity' => $newQty]);

            $order->update(['order_state_id' => $orderState->id, 'quantity' => $request->quantity, 'ministry_note_data' => $request->ministry_note_data]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order transferred successfully',
                'quantity' => $vaccineQty->quantity,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function transferToCancelled(Request $request, $id)
    {
        try {
            $order = Order::find($id);
            $orderState = Order_state::where('order_state', 'مرفوضة')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            $order->update(['order_state_id' => $orderState->id, 'ministry_note_data' => $request->ministry_note_data]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order transferred successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function undoCancelled($id)
    {
        try {
            $order = Order::find($id);
            $orderState = Order_state::where('order_state', 'صادرة')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            $order->update(['order_state_id' => $orderState->id, 'ministry_note_data' => null]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order transferred successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getDateRange()
    {
        try {

            $minDate = Carbon::parse(Order::min('created_at'))->toDateString();

            $maxDate = Carbon::parse(Order::max('created_at'))->toDateString();

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
