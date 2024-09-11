<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use App\Models\CityOfficeAccount;
use App\Models\DirectorateOfficeAccount;
use App\Models\HealthyCenterAccount;
use App\Models\MotherData;
use App\Models\Order;
use App\Models\OrderState;
use App\Models\Post;
use App\Models\User;
use App\Models\VaccineStock;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GeneralController extends Controller
{
    public function statistics(Request $request)
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

            // -------------------------Modified-------------------------------------
            $usersCount = User::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->count();
            $officesCount = null;
            $centersCount = null;
            $mothersCount = null;
            $childrenCount = null;
            $vaccinesCount = VaccineStock::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->count();
            $orderState = OrderState::where('order_state', 'تم التسليم')->first();
            $ordersCount = Order::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id], ['order_state_id', $orderState->id]])->count();
            $postsCount = null;

            if ($request->office_type_id == 1) {

                $officesCount = CityOfficeAccount::where([['city_office_account_phone', '!=', null], ['office_type_id', '!=', 1]])->count();

                $centersCount = HealthyCenterAccount::where('healthy_center_account_phone', '!=', null)->count();

                $mothersCount = MotherData::count();

                $childrenCount = ChildData::count();

                $postsCount = Post::where('office_type_id', $request->office_type_id)->count();

            } else if ($request->office_type_id == 2) {

                $officesCount = DirectorateOfficeAccount::where([['city_office_account_id', $request->office_account_id], ['directorate_office_account_phone', '!=', null]])->count();

                $centersCount = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.*')->where([['directorate_office_accounts.city_office_account_id', $request->office_account_id], ['healthy_center_account_phone', '!=', null]])->count();

                $mothersCount = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_account.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('mother_data.*', 'directorate_office_accounts.*')->where('directorate_office_accounts.city_office_account_id', $request->office_account_id)->count();

                $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_account.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('child_data.*', 'directorate_office_accounts.*')->where('directorate_office_accounts.city_office_account_id', $request->office_account_id)->count();

                $postsCount = Post::where('office_type_id', $request->office_type_id)->count();

            } else if ($request->office_type_id == 3) {

                $officesCount = HealthyCenterAccount::where([['directorate_office_account_id', $request->office_account_id], ['healthy_center_account_phone', '!=', null]])->count();

                $centersCount = HealthyCenterAccount::where([['directorate_office_account_id', $request->office_account_id], ['healthy_center_account_phone', '!=', null]])->count();

                $mothersCount = MotherData::join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'healthy_center_accounts.*')->where('healthy_center_accounts.directorate_office_account_id', $request->office_account_id)->count();

                $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('child_data.*', 'healthy_center_accounts.*')->where('healthy_center_accounts.directorate_office_account_id', $request->office_account_id)->count();

                $postsCount = null;

            } else if ($request->office_type_id == 4) {

                $officesCount = null;
                $centersCount = null;

                $mothersCount = MotherData::where('healthy_center_account_id', $request->office_account_id)->count();

                $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->select('child_data.*', 'mother_data.*')->where('mother_data.healthy_center_account_id', $request->office_account_id)->count();

                $postsCount = null;

            }

            // --------------------------------------------------------------

            return response()->json([
                'message' => 'Statistics retrieved successfully',
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

    // /////////////////////////////////// Offices //////////////////////////////////////////////

    // public function officesGetTotalCount($office_id)
    // {
    //     try {
    //         //-------------------------Modified------------------------------
    //         $usersCount = User::where('office_id', $office_id)->count();
    //         $centersCount = HealthyCenterAccount::where('office_id', $office_id)->count();
    //         $mothersCount = MotherData::join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
    //         $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->count();
    //         $vaccinesCount = VaccineStock::count();
    //         $orderState = OrderState::where('order_state', 'تم التسليم')->first();
    //         $ordersCount = Order::join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.office_id', $office_id)->where('order_state_id', $orderState->id)->count();
    //         //-------------------------------------------------------------------
    //         return response()->json([
    //             'message' => 'Total Count retrieved successfully',
    //             'data' => [
    //                 'users_count' => $usersCount,
    //                 'centers_count' => $centersCount,
    //                 'mothers_count' => $mothersCount,
    //                 'children_count' => $childrenCount,
    //                 'vaccines_count' => $vaccinesCount,
    //                 'orders_count' => $ordersCount,
    //             ],
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // /////////////////////////////////// Centers //////////////////////////////////////////////

    // public function centersGetTotalCount($center_id)
    // {
    //     try {
    //         $usersCount = User::where('healthy_center_id', $center_id)->count();
    //         $mothersCount = MotherData::where('healthy_center_id', $center_id)->count();
    //         $childrenCount = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->where('healthy_centers.id', $center_id)->count();
    //         $orderState = OrderState::where('order_state', 'تم التسليم')->first();

    //         //----------------------------Modified------------------------------
    //         $ordersCount = Order::where('healthy_center_id', $center_id)->where('order_state_id', $orderState->id)->count();
    //         //------------------------------------------------------------------

    //         return response()->json([
    //             'message' => 'Total Count retrieved successfully',
    //             'data' => [
    //                 'mothers_count' => $mothersCount,
    //                 'children_count' => $childrenCount,
    //                 'users_count' => $usersCount,
    //                 'orders_count' => $ordersCount,
    //             ],
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
}
