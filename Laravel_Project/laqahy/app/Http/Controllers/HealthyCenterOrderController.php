<?php

namespace App\Http\Controllers;

use App\Models\HealthyCenterOrder;
use App\Models\Healthy_centers_stock_vaccine;
use App\Models\Order;
use App\Models\OrderState;
use App\Models\VaccineStock;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class HealthyCenterOrderController extends Controller
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
    public function healthyCenterAddOrder(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'vaccine_type_id' => 'required',
                    'healthy_center_account_id' => 'required',
                    'quantity' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $orderState = OrderState::where('order_state', 'صادرة')->first();

            $order = Order::create([
                'vaccine_type_id' => $request->vaccine_type_id,
                'office_type_id' => $request->office_type_id,
                'office_account_id' => $request->office_account_id,
                'order_quantity' => $request->order_quantity,
                'order_request_date' => $request->order_request_date,
                'order_delivery_date' => $request->order_delivery_date,
                'order_sender_note' => $request->order_sender_note,
                'order_receiver_note' => $request->order_receiver_note,
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

    public function healthyCenterOutgoingOrders($center_id)
    {
        try {
            $outgoing = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_center_accounts.healthy_center_account_name')->where([['order_states.order_state', 'صادرة'], ['orders.office_account_id', $center_id]])->orderBy('orders.updated_at', 'desc')->get();
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

    public function healthyCenterInDeliveryOrders($center_id)
    {
        try {
            $inDelivery = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_center_accounts.healthy_center_account_name')->where([['order_states.order_state', 'قيد التسليم'], ['orders.office_account_id', $center_id]])->orderBy('orders.updated_at', 'desc')->get();
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

    public function healthyCenterDeliveredOrders($center_id)
    {
        try {
            $delivered = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_center_accounts.healthy_center_account_name')->where([['order_states.order_state', 'تم التسليم'], ['orders.office_account_id', $center_id]])->orderBy('orders.updated_at', 'desc')->get();
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

    public function healthyCenterRejectedOrders($center_id)
    {
        try {
            $rejected = Order::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->select('orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_center_accounts.healthy_center_account_name')->where([['order_states.order_state', 'مرفوضة'], ['orders.office_account_id', $center_id]])->orderBy('orders.updated_at', 'desc')->get();
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

    public function healthyCenterReceivingConfirmOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'healthy_center_account_id' => 'required',
                    'order_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $order = Order::find($request->order_id);

            $orderState = OrderState::where('order_state', 'تم التسليم')->first();

            $vaccine = VaccineStock::where([['vaccine_type_id', $order->vaccine_type_id], ['healthy_center_account_id', $request->healthy_center_account_id]])->first();

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

    public function healthyCenterGetDateRange($healthyCenterId)
    {
        try {
            $orderMinDate = Order::where('office_account_id', $healthyCenterId)->min('order_request_date');

            $orderMaxDate = Order::where('office_account_id', $healthyCenterId)->max('order_request_date');

            $minDate = Carbon::parse($orderMinDate)->toDateString();
            $maxDate = Carbon::parse($orderMaxDate)->toDateString();

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

    ////////////////////////////////// Offices /////////////////////////////////////

    public function directorateOfficeGetDateRange($directorateOfficeId)
    {
        try {
            $orderMinDate = Order::join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->min('orders.order_request_date');

            $orderMaxDate = Order::join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->where('healthy_center_accounts.directorate_office_account_id', $directorateOfficeId)->max('orders.order_request_date');

            $minDate = Carbon::parse($orderMinDate)->toDateString();
            $maxDate = Carbon::parse($orderMaxDate)->toDateString();

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
