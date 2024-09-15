<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderState;
use App\Models\VaccineStock;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function addOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                    'order_quantity' => 'required',
                    'vaccine_category' => 'required',
                    'vaccine_type_id' => 'required',
                    'order_sender_note' => 'required',
                ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $orderState = OrderState::where('order_state', 'صادرة')->first();

            $order = Order::create([
                'vaccine_category' => $request->vaccine_category, // [لقاحات الطفل \ لقاحات الام]
                'vaccine_type_id' => $request->vaccine_type_id,
                'office_type_id' => $request->office_type_id,
                'office_account_id' => $request->office_account_id,
                'order_quantity' => $request->order_quantity,
                'order_sender_note' => $request->order_sender_note,
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

    public function fetchOrders(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                    'vaccine_category' => 'required',
                    'order_state_id' => 'required',
                ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $order = null;

            if ($request->office_type_id == 1 || $request->office_type_id == 2) { // مكتب الوزارة او مكتب محافظة

                $order = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join($request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines' : 'child_vaccines', 'orders.vaccine_type_id', '=', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.id' : 'child_vaccines.id')->join('city_office_accounts', 'orders.office_account_id', '=', 'city_office_accounts.id')->select('orders.*', 'order_states.order_state', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.mother_vaccine_type' : 'child_vaccines.child_vaccine_type', 'city_office_accounts.city_office_account_name')->where([['orders.office_type_id', $request->office_type_id], ['orders.order_state_id', $request->order_state_id], ['orders.office_account_id', $request->office_account_id]])->orderBy('orders.updated_at', 'desc')->get();

            } else if ($request->office_type_id == 3) { // مكتب مديرية

                $order = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join($request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines' : 'child_vaccines', 'orders.vaccine_type_id', '=', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.id' : 'child_vaccines.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->select('orders.*', 'order_states.order_state', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.mother_vaccine_type' : 'child_vaccines.child_vaccine_type', 'directorate_office_accounts.directorate_office_account_name')->where([['orders.office_type_id', $request->office_type_id], ['orders.order_state_id', $request->order_state_id], ['orders.office_account_id', $request->office_account_id]])->orderBy('orders.updated_at', 'desc')->get();

            } else if ($request->office_type_id == 4) { // مركز صحي

                $order = Order::join('order_states', 'orders.order_state_id', '=', 'order_states.id')->join($request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines' : 'child_vaccines', 'orders.vaccine_type_id', '=', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.id' : 'child_vaccines.id')->join('healthy_center_accounts', 'orders.office_account_id', '=', 'healthy_center_accounts.id')->select('orders.*', 'order_states.order_state', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.mother_vaccine_type' : 'child_vaccines.child_vaccine_type', 'healthy_center_accounts.healthy_center_account_name')->where([['orders.office_type_id', $request->office_type_id], ['orders.order_state_id', $request->order_state_id], ['orders.office_account_id', $request->office_account_id]])->orderBy('orders.updated_at', 'desc')->get();

            } else {
                return response()->json([
                    'message' => 'Sorry, something is wrong',
                ], 402);
            }

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $order,
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function confirmReceiverOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
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

            $vaccine = VaccineStock::where([['vaccine_category', $order->vaccine_category], ['vaccine_type_id', $order->vaccine_type_id], ['office_type_id', $order->office_type_id], ['office_account_id', $order->office_account_id]])->first();

            $updatedVaccineQty = $vaccine->vaccine_quantity + $order->order_quantity;

            $vaccine->update([
                'vaccine_quantity' => $updatedVaccineQty,
            ]);

            $order->update(['order_state_id' => $orderState->id, 'order_delivery_date' => Carbon::now()]);

            return response()->json([
                'message' => 'Order received successfully',
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function approvalOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'order_id' => 'required',
                    'quantity' => 'required',
                    'order_receiver_note' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $order = Order::find($request->order_id);
            $orderState = OrderState::where('order_state', 'قيد التسليم')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            $vaccineQty = VaccineStock::where([['vaccine_category', $order->vaccine_category], ['vaccine_type_id', $order->vaccine_type_id], ['office_type_id', $order->office_type_id], ['office_account_id', $order->office_account_id]])->first();

            if ($request->quantity > $vaccineQty->vaccine_quantity) {
                return response()->json([
                    'message' => 'Vaccine quantity not enough',
                    'quantity' => $vaccineQty->quantity,
                ], 401);
            }

            $oldQty = $vaccineQty->vaccine_quantity;
            $newQty = $oldQty - $request->quantity;

            $vaccineQty->update(['vaccine_quantity' => $newQty]);

            $order->update(['order_state_id' => $orderState->id, 'order_quantity' => $request->quantity, 'order_receiver_note' => $request->order_receiver_note]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order approved successfully',
                'quantity' => $vaccineQty->vaccine_quantity,
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function rejectOrder(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'order_id' => 'required',
                    'order_receiver_note' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $order = Order::find($request->order_id);
            $orderState = OrderState::where('order_state', 'مرفوضة')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            $order->update(['order_state_id' => $orderState->id, 'order_receiver_note' => $request->order_receiver_note]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order rejected successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function undoRejectedOrder($id)
    {
        try {

            $order = Order::find($id);
            $orderState = OrderState::where('order_state', 'صادرة')->first();

            if (!$order) {
                return response()->json([
                    'message' => 'Order not found',
                ], 404);
            }

            $order->update(['order_state_id' => $orderState->id, 'order_receiver_note' => null]);

            // إعادة الاستجابة بالبيانات المحدثة
            return response()->json([
                'message' => 'Order undo rejected successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getDateRange(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $minDate = Carbon::parse(Order::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->min('order_request_date'))->toDateString();

            $maxDate = Carbon::parse(Order::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->max('order_request_date'))->toDateString();

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

    // public function centerOutgoingOrders($center_id)
    // {
    //     try {
    //         $outgoing = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'صادرة'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
    //         return response()->json([
    //             'message' => 'Outgoing orders retrieved successfully',
    //             'data' => $outgoing,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerInDeliveryOrders($center_id)
    // {
    //     try {
    //         $inDelivery = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'قيد التسليم'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
    //         return response()->json([
    //             'message' => 'In delivery orders retrieved successfully',
    //             'data' => $inDelivery,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerDeliveredOrders($center_id)
    // {
    //     try {
    //         $delivered = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'تم التسليم'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
    //         return response()->json([
    //             'message' => 'Delivered orders retrieved successfully',
    //             'data' => $delivered,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerRejectedOrders($center_id)
    // {
    //     try {
    //         $rejected = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'مرفوضة'], ['healthy_centers_orders.healthy_center_id', $center_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
    //         return response()->json([
    //             'message' => 'Rejected orders retrieved successfully',
    //             'data' => $rejected,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerGetDateRange($center_id)
    // {
    //     try {
    //         $orderMinDate = HealthyCenterOrder::where('healthy_center_id', $center_id)->min('order_date');

    //         $orderMaxDate = HealthyCenterOrder::where('healthy_center_id', $center_id)->max('order_date');

    //         $minDate = Carbon::parse($orderMinDate)->toDateString();
    //         $maxDate = Carbon::parse($orderMaxDate)->toDateString();

    //         return response()->json([
    //             'message' => 'Date range retrieved successfully',
    //             'min_date' => $minDate,
    //             'max_date' => $maxDate,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    ////////////////////////////////// Offices /////////////////////////////////////

    // public function officeGetDateRange($office_id)
    // {
    //     try {
    //         $orderMinDate = HealthyCenterOrder::join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->min('healthy_centers_orders.order_date');

    //         $orderMaxDate = HealthyCenterOrder::join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->max('healthy_centers_orders.order_date');

    //         $minDate = Carbon::parse($orderMinDate)->toDateString();
    //         $maxDate = Carbon::parse($orderMaxDate)->toDateString();

    //         return response()->json([
    //             'message' => 'Date range retrieved successfully',
    //             'min_date' => $minDate,
    //             'max_date' => $maxDate,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
}
