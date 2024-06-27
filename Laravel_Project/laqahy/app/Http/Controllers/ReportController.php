<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Healthy_center;
use App\Models\Ministry_statement_stock_vaccine;
use App\Models\Ministry_stock_vaccine;
use App\Models\Mother_data;
use App\Models\Office;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ReportController extends Controller
{
    // ----------------------------- Centers Report ----------------------------------
    public function generateCentersReport($id)
    {
        try {

            if ($id == 0) {
                $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.cities_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->orderBy('healthy_centers.id', 'asc')->get();
            } else {
                $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.cities_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->where('healthy_centers.office_id', $id)->orderBy('healthy_centers.id', 'asc')->get();
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
                $data = Mother_data::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = Child_data::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->select('child_data.*', 'genders.genders_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name')->where('mother_data.healthy_center_id', $request->center_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
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
                $data = Mother_data::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = Child_data::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('child_data.*', 'genders.genders_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
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
                $data = Mother_data::join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('cities', 'mother_data.cities_id', '=', 'cities.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->where('offices.id', $request->office_id)->whereBetween('mother_data.created_at', [$firstDate, $lastDate])->withCount('child_data as children_count')->orderBy('mother_data.id', 'asc')->get();
            } else if ($request->status_type == 2) {
                $data = Child_data::join('genders', 'child_data.gender_id', '=', 'genders.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('healthy_centers', 'mother_data.healthy_center_id', '=', 'healthy_centers.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('child_data.*', 'genders.genders_type', 'mother_data.mother_name', 'healthy_centers.healthy_center_name', 'offices.office_name')->where('offices.id', $request->office_id)->whereBetween('child_data.created_at', [$firstDate, $lastDate])->orderBy('child_data.id', 'asc')->get();
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
            $office = Office::withCount('healthyCenter as healthy_centers_count')->where('office_phone', '!=', null)->get();

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
    public function getVaccinesQtyReport()
    {
        try {
            $vaccineQty = Ministry_stock_vaccine::join('vaccine_types', 'ministry_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->select('ministry_stock_vaccines.*', 'vaccine_types.vaccine_type')->get();

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

            $vaccineStock = Ministry_statement_stock_vaccine::join('vaccine_types', 'ministry_statement_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'ministry_statement_stock_vaccines.donor_id', '=', 'donors.id')->select('ministry_statement_stock_vaccines.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->whereBetween('ministry_statement_stock_vaccines.date', [$firstDate, $lastDate])->orderBy('ministry_statement_stock_vaccines.id', 'asc')->get();

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

            $vaccineStock = Ministry_statement_stock_vaccine::join('vaccine_types', 'ministry_statement_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'ministry_statement_stock_vaccines.donor_id', '=', 'donors.id')->select('ministry_statement_stock_vaccines.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('ministry_statement_stock_vaccines.vaccine_type_id', $request->vaccine_type)->where('ministry_statement_stock_vaccines.donor_id', $request->donor)->whereBetween('ministry_statement_stock_vaccines.date', [$firstDate, $lastDate])->orderBy('ministry_statement_stock_vaccines.id', 'asc')->get();

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

            $vaccineStock = Ministry_statement_stock_vaccine::join('vaccine_types', 'ministry_statement_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'ministry_statement_stock_vaccines.donor_id', '=', 'donors.id')->select('ministry_statement_stock_vaccines.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('ministry_statement_stock_vaccines.donor_id', $request->donor)->whereBetween('ministry_statement_stock_vaccines.date', [$firstDate, $lastDate])->orderBy('ministry_statement_stock_vaccines.id', 'asc')->get();

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

            $vaccineStock = Ministry_statement_stock_vaccine::join('vaccine_types', 'ministry_statement_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'ministry_statement_stock_vaccines.donor_id', '=', 'donors.id')->select('ministry_statement_stock_vaccines.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->where('ministry_statement_stock_vaccines.vaccine_type_id', '=', $request->vaccine_type)->whereBetween('ministry_statement_stock_vaccines.date', [$firstDate, $lastDate])->orderBy('ministry_statement_stock_vaccines.id', 'asc')->get();

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

    // -------------------------------------------------------------------------------

}
