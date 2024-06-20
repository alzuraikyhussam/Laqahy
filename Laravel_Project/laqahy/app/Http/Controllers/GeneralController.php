<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Healthy_center;
use App\Models\Mother_data;
use App\Models\Office;
use App\Models\Order;
use App\Models\Order_state;
use App\Models\Post;
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
            $orderState = Order_state::where('order_state', 'delivered')->first();
            $ordersCount = Order::where('order_state_id', $orderState->id)->count();
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

}
