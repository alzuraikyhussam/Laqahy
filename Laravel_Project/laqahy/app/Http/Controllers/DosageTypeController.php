<?php

namespace App\Http\Controllers;

use App\Models\Dosage_type;
use App\Models\Mother_statement;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class DosageTypeController extends Controller
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
    public function show(string $dosageLevelId, string $motherId)
    {
        try {
            // Check if the mother exists
            $mother = Mother_statement::where('mother_data_id', $motherId)->first();

            if (!$mother) {
                // If the mother is not found, return all the dosage types for the given dosage level ID
                $Dosage_type = Dosage_type::where('dosage_level_id', $dosageLevelId)->get();
                return response()->json([
                    'message' => 'Dosage types retrieved successfully',
                    'data' => $Dosage_type,
                ]);
            }

            // Get the dosage types that the mother has not taken
            $motherStatement = Dosage_type::whereNotIn('id', function ($query) use ($motherId) {
                $query->select('dosage_type_id')
                    ->from('mother_statements')
                    ->where('mother_statements.mother_data_id', $motherId)
                    ->whereNull('mother_statements.deleted_at');
            })
            ->where('dosage_level_id', $dosageLevelId)
            ->get();

            return response()->json([
                'message' => 'Mother statement retrieved successfully',
                'data' => $motherStatement,
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
}
