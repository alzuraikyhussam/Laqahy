<?php

namespace App\Http\Controllers;

use App\Models\Healthy_center;
use Exception;
use Illuminate\Http\Request;

use function Laravel\Prompts\select;

class HealthyCenterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.cities_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->orderBy('healthy_centers.id', 'asc')->get();

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

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function getCentersByOffice($id)
    {
        try {
            $center = Healthy_center::join('directorates', 'healthy_centers.directorate_id', '=', 'directorates.id')->join('cities', 'healthy_centers.cities_id', '=', 'cities.id')->join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'cities.city_name', 'directorates.directorate_name', 'offices.office_name')->where('healthy_centers.office_id', $id)->orderBy('healthy_centers.id', 'asc')->get();
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
}
