<?php

namespace App\Http\Controllers;

use App\Models\Child_dosage_type;
use App\Models\Child_statement;
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
    public function show(string $vaccineTypeId, string $childId)
    {
        try {
            // Check if the child exists
            $child = Child_statement::where('child_data_id', $childId)->first();

            if (!$child) {
                $vaccineWithVisit = Vaccines_with_dosage::join('child_dosage_types', 'vaccines_with_dosages.child_dosage_type_id', '=', 'child_dosage_types.id')
                    ->select('vaccines_with_dosages.child_dosage_type_id', 'child_dosage_types.child_dosage_type')
                    ->where('vaccines_with_dosages.vaccine_type_id', $vaccineTypeId)
                    ->get();
                return response()->json([
                    'message' => 'Dosage types retrieved successfully',
                    'data' => $vaccineWithVisit,
                ]);
            }

            // Get the vaccine dosage types that the child has not taken
            $childStatement = Vaccines_with_dosage::join('child_dosage_types', 'vaccines_with_dosages.child_dosage_type_id', '=', 'child_dosage_types.id')
                ->select('vaccines_with_dosages.child_dosage_type_id', 'child_dosage_types.child_dosage_type')
                ->whereNotIn('child_dosage_type_id', function ($query) use ($childId) {
                    $query->select('child_dosage_type_id')
                        ->from('child_statements')
                        ->where('child_statements.child_data_id', $childId)
                        ->whereNull('child_statements.deleted_at');
                })
                ->where('vaccines_with_dosages.vaccine_type_id', $vaccineTypeId)
                ->get();

            return response()->json([
                'message' => 'Child statement retrieved successfully',
                'data' => $childStatement,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
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
