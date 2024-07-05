<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Healthy_center;
use App\Models\HealthyCenterOrder;
use App\Models\Mother_data;
use App\Models\Office;
use App\Models\OfficeOrder;
use App\Models\Order_state;
use App\Models\Post;
use App\Models\User;
use App\Models\Vaccine_type;
use Exception;
use Illuminate\Http\Request;

class GeneralController extends Controller
{
    public function getTotalCount()
    {
        try {
            $officesCount = Office::where('office_phone', '!=', null)->count();
            $centersCount = Healthy_center::count();
            $mothersCount = Mother_data::count();
            $childrenCount = Child_data::count();
            $vaccinesCount = Vaccine_type::count();
            $orderState = Order_state::where('order_state', 'تم التسليم')->first();
            $ordersCount = OfficeOrder::where('order_state_id', $orderState->id)->count();
            $postsCount = Post::count();

            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'offices_count' => $officesCount,
                    'centers_count' => $centersCount,
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'vaccines_count' => $vaccinesCount,
                    'orders_count' => $ordersCount,
                    'posts_count' => $postsCount,
                ]
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
            $centersCount = Healthy_center::where('office_id', $office_id)->count();
            $mothersCount = Mother_data::join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
            $childrenCount = Child_data::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
            $vaccinesCount = Vaccine_type::count();
            $orderState = Order_state::where('order_state', 'تم التسليم')->first();
            $ordersCount = OfficeOrder::where('office_id', $office_id)->where('order_state_id', $orderState->id)->count();

            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'centers_count' => $centersCount,
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'vaccines_count' => $vaccinesCount,
                    'orders_count' => $ordersCount,
                ]
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
            $mothersCount = Mother_data::where('healthy_center_id', $center_id)->count();
            $childrenCount = Child_data::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.id', $center_id)->count();
            $orderState = Order_state::where('order_state', 'تم التسليم')->first();
            $ordersCount = HealthyCenterOrder::where('healthy_center_id', $center_id)->where('order_state_id', $orderState->id)->count();

            return response()->json([
                'message' => 'Total Count retrieved successfully',
                'data' => [
                    'mothers_count' => $mothersCount,
                    'children_count' => $childrenCount,
                    'users_count' => $usersCount,
                    'orders_count' => $ordersCount,
                ]
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
