<?php

namespace App\Http\Controllers;

use App\Models\VisitType;
use App\Models\VisitWithChildVaccine;
use Exception;
use Illuminate\Http\Request;

class VisitTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $visitType = VisitType::get();
            return response()->json([
                'message' => 'Visit Type retrieved successfully',
                'data' => $visitType,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
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
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
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

    public function getVaccinesFromVisit(string $visitTypeId)
    {
        try {
            $vaccineWithVisit = VisitWithChildVaccine::join('vaccine_types', 'visit_with_child_vaccine.vaccine_type_id', '=', 'vaccine_types.id')->select('visit_with_child_vaccine.vaccine_type_id', 'vaccine_types.vaccine_type', )->where('visit_with_child_vaccine.visit_type_id', $visitTypeId)->get();
            return response()->json([
                'message' => 'Vaccine data retrieved successfully',
                'data' => $vaccineWithVisit,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
