<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use App\Models\City;
use App\Models\CityOfficeAccount;
use App\Models\HealthyCenterOrder;
use App\Models\Healthy_center;
use App\Models\HealthyCenterAccount;
use App\Models\MotherData;
use App\Models\Office;
use App\Models\OfficeOrder;
use App\Models\Offices_users;
use App\Models\Order;
use App\Models\OrderState;
use App\Models\Post;
use App\Models\User;
use App\Models\VaccineStock;
use App\Models\VaccineType;
use Exception;

class GeneralController extends Controller
{
    public function getTotalCount($office_id)
    {
        try {
            // -------------------------Modified-------------------------------------
            $usersCount = User::where('office_id', $office_id)->count();
            $officesCount = CityOfficeAccount::where([['office_phone', '!=', null], ['office_name', '!=', 'وزارة الصحة والسكان']])->count();
            $centersCount = HealthyCenterAccount::count();
            $mothersCount = MotherData::count();
            $childrenCount = ChildData::count();
            $vaccinesCount = VaccineStock::count();
            $orderState = OrderState::where('order_state', 'تم التسليم')->first();
            $ordersCount = Order::where('order_state_id', $orderState->id)->count();
            $postsCount = Post::count();
            // --------------------------------------------------------------

            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'users_count' => $usersCount,
                    'offices_count' => $officesCount,
                    'centers_count' => $centersCount,
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'vaccines_count' => $vaccinesCount,
                    'orders_count' => $ordersCount,
                    'posts_count' => $postsCount,
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /////////////////////////////////// Offices //////////////////////////////////////////////

    public function officesGetTotalCount($office_id)
    {
        try {
            //-------------------------Modified------------------------------
            $usersCount = User::where('office_id', $office_id)->count();
            $centersCount = HealthyCenterAccount::where('office_id', $office_id)->count();
            $mothersCount = MotherData::join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
            $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
            $vaccinesCount = VaccineStock::count();
            $orderState = OrderState::where('order_state', 'تم التسليم')->first();
            $ordersCount = Order::join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->where('order_state_id', $orderState->id)->count();
            //-------------------------------------------------------------------
            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'users_count' => $usersCount,
                    'centers_count' => $centersCount,
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'vaccines_count' => $vaccinesCount,
                    'orders_count' => $ordersCount,
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /////////////////////////////////// Centers //////////////////////////////////////////////

    public function centersGetTotalCount($center_id)
    {
        try {
            $usersCount = User::where('healthy_center_id', $center_id)->count();
            $mothersCount = MotherData::where('healthy_center_id', $center_id)->count();
            $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.id', $center_id)->count();
            $orderState = OrderState::where('order_state', 'تم التسليم')->first();

            //----------------------------Modified------------------------------
            $ordersCount = Order::where('healthy_center_id', $center_id)->where('order_state_id', $orderState->id)->count();
            //------------------------------------------------------------------
            
            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'users_count' => $usersCount,
                    'orders_count' => $ordersCount,
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
