<?php

namespace App\Http\Controllers;

use App\Models\HealthyCenterOrder;
use App\Models\Ministry_stock_vaccine;
use App\Models\OfficeOrder;
use App\Models\Office_stock_vaccine;
use App\Models\OrderState;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

// class OfficeOrderController extends Controller
// {
//     public function incomingOrders()
//     {
//         try {
//             $incoming = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'صادرة')->orderBy('updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Incoming orders retrieved successfully',
//                 'data' => $incoming,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function inDeliveryOrders()
//     {
//         try {
//             $inDelivery = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'قيد التسليم')->orderBy('updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'In delivery orders retrieved successfully',
//                 'data' => $inDelivery,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function deliveredOrders()
//     {
//         try {
//             $delivered = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'تم التسليم')->orderBy('updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Delivered orders retrieved successfully',
//                 'data' => $delivered,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function rejectedOrders()
//     {
//         try {
//             $rejected = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where('order_states.order_state', 'مرفوضة')->orderBy('updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Rejected orders retrieved successfully',
//                 'data' => $rejected,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function approvalOrder(Request $request, $id)
//     {
//         try {
//             $order = OfficeOrder::find($id);
//             $vaccineQty = Ministry_stock_vaccine::where('vaccine_type_id', $order->vaccine_type_id)->first();
//             $orderState = OrderState::where('order_state', 'قيد التسليم')->first();

//             if (!$order) {
//                 return response()->json([
//                     'message' => 'Order not found',
//                 ], 404);
//             }

//             if ($request->quantity > $vaccineQty->quantity) {
//                 return response()->json([
//                     'message' => 'Vaccine quantity not enough',
//                     'quantity' => $vaccineQty->quantity,
//                 ], 401);
//             }

//             $oldQty = $vaccineQty->quantity;
//             $newQty = $oldQty - $request->quantity;

//             $vaccineQty->update(['quantity' => $newQty]);

//             $order->update(['order_state_id' => $orderState->id, 'quantity' => $request->quantity, 'ministry_note_data' => $request->ministry_note_data]);

//             // إعادة الاستجابة بالبيانات المحدثة
//             return response()->json([
//                 'message' => 'Order transferred successfully',
//                 'quantity' => $vaccineQty->quantity,
//             ], 200);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function rejectOrder(Request $request, $id)
//     {
//         try {
//             $order = OfficeOrder::find($id);
//             $orderState = OrderState::where('order_state', 'مرفوضة')->first();

//             if (!$order) {
//                 return response()->json([
//                     'message' => 'Order not found',
//                 ], 404);
//             }

//             $order->update(['order_state_id' => $orderState->id, 'ministry_note_data' => $request->ministry_note_data]);

//             // إعادة الاستجابة بالبيانات المحدثة
//             return response()->json([
//                 'message' => 'Order transferred successfully',
//             ], 200);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function undoRejectedOrder($id)
//     {
//         try {
//             $order = OfficeOrder::find($id);
//             $orderState = OrderState::where('order_state', 'صادرة')->first();

//             if (!$order) {
//                 return response()->json([
//                     'message' => 'Order not found',
//                 ], 404);
//             }

//             $order->update(['order_state_id' => $orderState->id, 'ministry_note_data' => null]);

//             // إعادة الاستجابة بالبيانات المحدثة
//             return response()->json([
//                 'message' => 'Order undo successfully',
//             ], 200);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function getDateRange()
//     {
//         try {

//             $minDate = Carbon::parse(OfficeOrder::min('order_date'))->toDateString();

//             $maxDate = Carbon::parse(OfficeOrder::max('order_date'))->toDateString();

//             return response()->json([
//                 'message' => 'Date range retrieved successfully',
//                 'min_date' => $minDate,
//                 'max_date' => $maxDate,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     ////////////////////////////////// Offices /////////////////////////////////////

//     public function officeAddOrder(Request $request)
//     {
//         try {
//             $validator = Validator::make(
//                 $request->all(),
//                 [
//                     'vaccine_type_id' => 'required',
//                     'office_id' => 'required',
//                     'quantity' => 'required',
//                 ],
//             );

//             if ($validator->fails()) {
//                 return response()->json([
//                     'message' => $validator->errors(),
//                 ], 400);
//             }

//             $orderState = OrderState::where('order_state', 'صادرة')->first();

//             $order = OfficeOrder::create([
//                 'vaccine_type_id' => $request->vaccine_type_id,
//                 'office_id' => $request->office_id,
//                 'quantity' => $request->quantity,
//                 'office_note_data' => $request->office_note_data,
//                 'order_state_id' => $orderState->id,
//             ]);

//             return response()->json([
//                 'message' => 'Order created successfully',
//             ], 201);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),

//             ], 500);
//         }
//     }

//     public function officeOutgoingOrders($office_id)
//     {
//         try {
//             $outgoing = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where([['order_states.order_state', 'صادرة'], ['offices_orders.office_id', $office_id]])->orderBy('offices_orders.updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Outgoing orders retrieved successfully',
//                 'data' => $outgoing,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeIncomingOrders($office_id)
//     {
//         try {
//             $incoming = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'صادرة'], ['healthy_centers.office_id', $office_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Incoming orders retrieved successfully',
//                 'data' => $incoming,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeInDeliveryOrders($office_id)
//     {
//         try {
//             $inDelivery = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where([['order_states.order_state', 'قيد التسليم'], ['offices_orders.office_id', $office_id]])->orderBy('offices_orders.updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'In delivery orders retrieved successfully',
//                 'data' => $inDelivery,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeDeliveredOrders($office_id)
//     {
//         try {
//             $delivered = HealthyCenterOrder::join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->select('healthy_centers_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name')->where([['order_states.order_state', 'تم التسليم'], ['healthy_centers.office_id', $office_id]])->orderBy('healthy_centers_orders.updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Delivered orders retrieved successfully',
//                 'data' => $delivered,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeRejectedOrders($office_id)
//     {
//         try {
//             $rejected = OfficeOrder::join('order_states', 'offices_orders.order_state_id', '=', 'order_states.id')->join('vaccine_types', 'offices_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('offices', 'offices_orders.office_id', '=', 'offices.id')->select('offices_orders.*', 'order_states.order_state', 'vaccine_types.vaccine_type', 'offices.office_name')->where([['order_states.order_state', 'مرفوضة'], ['offices_orders.office_id', $office_id]])->orderBy('offices_orders.updated_at', 'desc')->get();
//             return response()->json([
//                 'message' => 'Rejected orders retrieved successfully',
//                 'data' => $rejected,
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeReceivingConfirmOrder(Request $request)
//     {
//         try {

//             $validator = Validator::make(
//                 $request->all(),
//                 [
//                     'office_id' => 'required',
//                     'order_id' => 'required',
//                 ],
//             );

//             if ($validator->fails()) {
//                 return response()->json([
//                     'message' => $validator->errors(),
//                 ], 400);
//             }

//             $order = OfficeOrder::find($request->order_id);

//             $orderState = OrderState::where('order_state', 'تم التسليم')->first();

//             $vaccine = Office_stock_vaccine::where([['vaccine_type_id', $order->vaccine_type_id], ['office_id', $request->office_id]])->first();

//             $updatedVaccineQty = $vaccine->quantity + $order->quantity;

//             $vaccine->update([
//                 'quantity' => $updatedVaccineQty,
//             ]);

//             $order->update(['order_state_id' => $orderState->id, 'delivery_date' => Carbon::now()]);

//             return response()->json([
//                 'message' => 'Order received successfully',
//             ]);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeApprovalCenterOrder(Request $request, $id)
//     {
//         try {
//             $order = HealthyCenterOrder::find($id);
//             $vaccineQty = Office_stock_vaccine::where([['vaccine_type_id', $order->vaccine_type_id], ['office_id', $request->office_id]])->first();
//             $orderState = OrderState::where('order_state', 'قيد التسليم')->first();

//             if (!$order) {
//                 return response()->json([
//                     'message' => 'Order not found',
//                 ], 404);
//             }

//             if ($request->quantity > $vaccineQty->quantity) {
//                 return response()->json([
//                     'message' => 'Vaccine quantity not enough',
//                     'quantity' => $vaccineQty->quantity,
//                 ], 401);
//             }

//             $oldQty = $vaccineQty->quantity;
//             $newQty = $oldQty - $request->quantity;

//             $vaccineQty->update(['quantity' => $newQty]);

//             $order->update(['order_state_id' => $orderState->id, 'quantity' => $request->quantity, 'office_note_data' => $request->office_note_data]);

//             // إعادة الاستجابة بالبيانات المحدثة
//             return response()->json([
//                 'message' => 'Order confirmed successfully',
//                 'quantity' => $vaccineQty->quantity,
//             ], 200);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }

//     public function officeRejectCenterOrder(Request $request, $id)
//     {
//         try {
//             $order = HealthyCenterOrder::find($id);

//             $orderState = OrderState::where('order_state', 'مرفوضة')->first();

//             if (!$order) {
//                 return response()->json([
//                     'message' => 'Order not found',
//                 ], 404);
//             }

//             $order->update(['order_state_id' => $orderState->id, 'office_note_data' => $request->office_note_data]);

//             return response()->json([
//                 'message' => 'Order rejected successfully',
//             ], 200);
//         } catch (Exception $e) {
//             return response()->json([
//                 'message' => $e->getMessage(),
//             ], 500);
//         }
//     }
// }
