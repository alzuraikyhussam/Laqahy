<?php

namespace App\Http\Controllers;

use App\Models\DosageLevel;
use Exception;
use Illuminate\Http\Request;

class DosageLevelController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {

            $DosageLevel = DosageLevel::get();

            return response()->json([
                'message' => 'Dosages level retrieved successfully',
                'data' => $DosageLevel,
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
}
