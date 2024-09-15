<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use App\Models\CityOfficeAccount;
use App\Models\DirectorateOfficeAccount;
use App\Models\HealthyCenterOrder;
use App\Models\Healthy_center;
use App\Models\Healthy_centers_stock_vaccine;
use App\Models\HealthyCenterAccount;
use App\Models\Ministry_statement_stock_vaccine;
use App\Models\Ministry_stock_vaccine;
use App\Models\MotherData;
use App\Models\Office;
use App\Models\OfficeOrder;
use App\Models\Office_stock_vaccine;
use App\Models\Order;
use App\Models\VaccineStock;
use App\Models\VaccineStockStatement;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    // ----------------------------- Centers Report ----------------------------------
    public function generateCentersReport($id)
    {
        try {

            if ($id == 0) {
                $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->orderBy('healthy_center_accounts.id', 'asc')->get();
            } else {
                $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.directorate_office_account_id', $id)->orderBy('healthy_center_accounts.id', 'asc')->get();
            }

            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $center,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Status Report ----------------------------------
    public function generateStatusReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_center_accounts.healthy_center_account_name')->where('mother_data.healthy_center_account_id', $request->center_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateStatusInAllOfficesReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_center_accounts.healthy_center_account_name', 'directorate_office_accounts.directorate_office_account_name')->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'directorate_office_accounts.directorate_office_account_name')->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateStatusInAllCentersReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_center_accounts.healthy_center_account_name', 'directorate_office_accounts.directorate_office_account_name')->where('directorate_office_accounts.id', $request->office_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'directorate_office_accounts.directorate_office_account_name')->where('directorate_office_accounts.id', $request->office_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Offices Report ----------------------------------
    public function getOfficesReport()
    {
        try {
            $office = DirectorateOfficeAccount::withCount('healthyCenter as healthy_centers_count')->where([['directorate_office_account_phone', '!=', null], ['directorate_office_account_name', '!=', 'وزارة الصحة والسكان']])->get();

            return response()->json([
                'message' => 'Offices retrieved successfully',
                'data' => $office,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Ministry Vaccines Report ----------------------------------
    // public function getVaccinesQtyReport()
    // {
    //     try {
    //         $vaccineQty = Ministry_stock_vaccine::join('vaccine_types', 'ministry_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('ministry_stock_vaccines.*', 'vaccine_types.vaccine_type')->get();

    //         return response()->json([
    //             'message' => 'Vaccines quantity retrieved successfully',
    //             'data' => $vaccineQty,
    //         ]);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    public function getVaccinesQtyReport()
    {
        try {
            $vaccineQty = VaccineStock::join('vaccine_types', 'vaccine_stock.vaccine_type_id', '=', 'vaccine_types.id')->select('vaccine_stock.*', 'vaccine_types.vaccine_type')->where('vaccine_stock.office_type_id','1')->get();

            return response()->json([
                'message' => 'Vaccines quantity retrieved successfully',
                'data' => $vaccineQty,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateVaccinesStockAllReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $vaccineStock = VaccineStockStatement::join('vaccine_types', 'vaccine_stock_statements.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'vaccine_stock_statements.donor_id', '=', 'donors.id')->select('vaccine_stock_statements.*', 'vaccine_types.vaccine_type', 'donors.donor_name')
            ->where('vaccine_stock_statements.office_type_id','1')->whereBetween('vaccine_stock_statements.date', [$firstDate, $lastDate])->orderBy('vaccine_stock_statements.id', 'asc')->get();

            return response()->json([
                'message' => 'Vaccines stock retrieved successfully',
                'data' => $vaccineStock,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Ministry Vaccine Statement Report ----------------------------------
    public function generateVaccinesStockCustomReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $vaccineStock = VaccineStockStatement::join('vaccine_types', 'vaccine_stock_statements.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'vaccine_stock_statements.donor_id', '=', 'donors.id')->select('vaccine_stock_statements.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('vaccine_stock_statements.office_type_id','1')->where('ministry_statement_stock_vaccines.vaccine_type_id', $request->vaccine_type)->where('vaccine_stock_statements.donor_id', $request->donor)->whereBetween('vaccine_stock_statements.date', [$firstDate, $lastDate])->orderBy('vaccine_stock_statements.id', 'asc')->get();

            return response()->json([
                'message' => 'Vaccines stock retrieved successfully',
                'data' => $vaccineStock,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllVaccinesStockOfSpecificDonorReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $vaccineStock = VaccineStockStatement::join('vaccine_types', 'vaccine_stock_statements.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'vaccine_stock_statements.donor_id', '=', 'donors.id')->select('vaccine_stock_statements.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('vaccine_stock_statements.office_type_id','1')->where('vaccine_stock_statements.donor_id', $request->donor)->whereBetween('vaccine_stock_statements.date', [$firstDate, $lastDate])->orderBy('vaccine_stock_statements.id', 'asc')->get();

            return response()->json([
                'message' => 'Vaccines stock retrieved successfully',
                'data' => $vaccineStock,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateSpecificVaccineStockOfAllDonorsReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $vaccineStock = VaccineStockStatement::join('vaccine_types', 'vaccine_stock_statements.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'vaccine_stock_statements.donor_id', '=', 'donors.id')->select('vaccine_stock_statements.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('vaccine_stock_statements.office_type_id','1')->where('vaccine_stock_statements.vaccine_type_id', '=', $request->vaccine_type)->whereBetween('vaccine_stock_statements.date', [$firstDate, $lastDate])->orderBy('vaccine_stock_statements.id', 'asc')->get();

            return response()->json([
                'message' => 'Vaccines stock retrieved successfully',
                'data' => $vaccineStock,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Orders Report ----------------------------------
    public function generateAllOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllVaccinesOfAllOfficesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.order_state_id', $request->order_state)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllStatesOfAllOfficesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.vaccine_type_id', $request->vaccine_type)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllStatesOfAllVaccinesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.office_account_id', $request->office)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllOfficesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.vaccine_type_id', $request->vaccine_type)->where('orders.order_state_id', $request->order_state)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllVaccinesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.office_account_id', $request->office)->where('orders.order_state_id', $request->order_state)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('offices_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateAllStatesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.office_account_id', $request->office)->where('orders.vaccine_type_id', $request->vaccine_type)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateCustomOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = Order::join('vaccine_types', 'orders.vaccine_type_id', '=', 'vaccine_types.id')->join('directorate_office_accounts', 'orders.office_account_id', '=', 'directorate_office_accounts.id')->join('order_states', 'orders.order_state_id', '=', 'order_states.id')->select('orders.*', 'vaccine_types.vaccine_type', 'directorate_office_accounts.directorate_office_account_name', 'order_states.order_state')->where('orders.office_account_id', $request->office)->where('orders.vaccine_type_id', $request->vaccine_type)->where('orders.order_state_id', $request->order_state)->whereBetween('orders.order_request_date', [$firstDate, $lastDate])->orderBy('orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    /////////////////////////// Offices ////////////////////////////////

    // ----------------------------- Centers Report ----------------------------------
    public function officeGenerateCentersReport($office_id)
    {
        try {
            $center = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.directorate_office_account_id', $office_id)->orderBy('healthy_center_accounts.id', 'asc')->get();

            return response()->json([
                'message' => 'Centers retrieved successfully',
                'data' => $center,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Office Vaccines Report ----------------------------------
    public function officeGetVaccinesQtyReport($office_id)
    {
        try {
            $vaccineQty = VaccineStock::join('vaccine_types', 'vaccine_stock.vaccine_type_id', '=', 'vaccine_types.id')->select('vaccine_stock.*', 'vaccine_types.vaccine_type')->where('vaccine_stock.office_account_id', $office_id)->get();

            return response()->json([
                'message' => 'Vaccines quantity retrieved successfully',
                'data' => $vaccineQty,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Status Report ----------------------------------
    public function officeGenerateStatusReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateStatusInAllCentersReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->where('offices.id', $request->office_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->where('offices.id', $request->office_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Orders Report ----------------------------------
    public function officeGenerateAllOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers.office_id', $request->office_id)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllVaccinesOfAllCentersOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers.office_id', $request->office_id)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllStatesOfAllCentersOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers.office_id', $request->office_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllStatesOfAllVaccinesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllCentersOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers.office_id', $request->office_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllVaccinesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateAllStatesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGenerateCustomOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    /////////////////////////// Centers ////////////////////////////////

    // ----------------------------- Center Vaccines Report ----------------------------------
    public function centerGetVaccinesQtyReport($center_id)
    {
        try {
            $vaccineQty = Healthy_centers_stock_vaccine::join('vaccine_types', 'healthy_centers_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('healthy_centers_stock_vaccines.*', 'vaccine_types.vaccine_type')->where('healthy_centers_stock_vaccines.healthy_center_id', $center_id)->get();

            return response()->json([
                'message' => 'Vaccines quantity retrieved successfully',
                'data' => $vaccineQty,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Orders Report ----------------------------------
    public function centerGenerateAllOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerGenerateAllVaccinesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerGenerateAllStatesOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function centerGenerateCustomOrdersReport(Request $request)
    {
        try {
            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            $orders = HealthyCenterOrder::join('vaccine_types', 'healthy_centers_orders.vaccine_type_id', '=', 'vaccine_types.id')->join('healthy_centers', 'healthy_centers_orders.healthy_center_id', '=', 'healthy_centers.id')->join('order_states', 'healthy_centers_orders.order_state_id', '=', 'order_states.id')->select('healthy_centers_orders.*', 'vaccine_types.vaccine_type', 'healthy_centers.healthy_center_name', 'order_states.order_state')->where('healthy_centers_orders.healthy_center_id', $request->center_id)->where('healthy_centers_orders.vaccine_type_id', $request->vaccine_type)->where('healthy_centers_orders.order_state_id', $request->order_state)->whereBetween('healthy_centers_orders.order_date', [$firstDate, $lastDate])->orderBy('healthy_centers_orders.id', 'asc')->get();

            return response()->json([
                'message' => 'Orders retrieved successfully',
                'data' => $orders,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

    // ----------------------------- Status Report ----------------------------------
    public function centerGenerateStatusReport(Request $request)
    {
        try {

            $firstDate = Carbon::parse($request->first_date)->startOfDay();
            $lastDate = Carbon::parse($request->last_date)->endOfDay();

            if ($request->status_type == 1) {
                $data = MotherData::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.city_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = ChildData::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('child_data.*', 'genders.gender_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
            } else {
                return response()->json([
                    'message' => 'Data not found',
                ]);
            }

            return response()->json([
                'message' => 'Data retrieved successfully',
                'data' => $data,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    // -------------------------------------------------------------------------------

}
