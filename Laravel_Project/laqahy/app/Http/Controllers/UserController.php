<?php

namespace App\Http\Controllers;

use App\Models\User;
use Exception;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $user = User::join('permission_types', 'users.permission_type_id', '=', 'permission_types.id')->join('genders', 'users.gender_id', '=', 'genders.id')->join('healthy_centers', 'users.healthy_center_id', '=', 'healthy_centers.id')->select('users.*', 'genders.genders_type', 'healthy_centers.healthy_center_name', 'permission_types.permission_type')->get();
            return response()->json([
                'message' => 'Users retrieved successfully',
                'data' => $user,
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
}
