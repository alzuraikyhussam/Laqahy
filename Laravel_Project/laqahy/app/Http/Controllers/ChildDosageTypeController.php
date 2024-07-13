<?php

namespace App\Http\Controllers;

use App\Models\Vaccines_with_dosage;
use Exception;
use Illuminate\Http\Request;

class ChildDosageTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
    public function getDosagesFromVaccine(string $vaccineTypeId)
    {
        try {
            $vaccineWithVisit = Vaccines_with_dosage::join('child_dosage_types', 'vaccines_with_dosages.child_dosage_type_id', '=', 'child_dosage_types.id')->select('vaccines_with_dosages.child_dosage_type_id', 'child_dosage_types.child_dosage_type',)->where('vaccines_with_dosages.vaccine_type_id', $vaccineTypeId)->get();
            return response()->json([
                'message' => 'Dosage data retrieved successfully',
                'data' => $vaccineWithVisit,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
