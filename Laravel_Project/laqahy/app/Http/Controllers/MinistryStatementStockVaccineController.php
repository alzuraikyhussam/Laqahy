<?php

namespace App\Http\Controllers;

use App\Models\Ministry_statement_stock_vaccine;
use App\Models\Ministry_stock_vaccine;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MinistryStatementStockVaccineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $vaccine = Ministry_statement_stock_vaccine::join('vaccine_types', 'ministry_statement_stock_vaccines.vaccine_type_id', '=', 'vaccine_types.id')->join('donors', 'ministry_statement_stock_vaccines.donor_id', '=', 'donors.id')->select('ministry_statement_stock_vaccines.*', 'vaccine_types.vaccine_type', 'donors.donor_name')->orderBy('id', 'desc')->get();
            return response()->json([
                'message' => 'Vaccines quantity retrieved successfully',
                'data' => $vaccine,
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
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'vaccine_type_id' => 'required',
                    'quantity' => 'required',
                    'donor_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // Create record
            $addQty = Ministry_statement_stock_vaccine::create([
                'vaccine_type_id' => $request->vaccine_type_id,
                'quantity' => $request->quantity,
                'donor_id' => $request->donor_id,
            ]);

            $vaccineQty = Ministry_stock_vaccine::where('vaccine_type_id', $request->vaccine_type_id)->first();
            $newQty = $vaccineQty->quantity + $request->quantity;
            $vaccineQty->update([
                'quantity' => $newQty,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Vaccine quantity created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }
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
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'vaccine_type_id' => 'required',
                    'quantity' => 'required',
                    'donor_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $statement = Ministry_statement_stock_vaccine::find($id);

            if (!$statement) {
                return response()->json([
                    'message' => 'Statement not found',
                ], 404);
            }

            $oldQty = $statement->quantity;
            $newQty = $request->quantity;
            $quantityDifference = $newQty - $oldQty;

            $vaccine = Ministry_stock_vaccine::where('vaccine_type_id', $statement->vaccine_type_id)->first();

            // التحقق من ان التحديث لن يؤدي الى قيمة سالبة
            if ($vaccine->quantity + $quantityDifference < 0) {
                return response()->json([
                    'message' => 'Can not update this vaccine statement now',
                ], 401);
            }

            // تحديث الكمية في جدول بيان اللقاح
            $statement->update(['donor_id' => $request->donor_id, 'quantity' => $newQty]);

            // تحديث الكمية في جدول اللقاحات
            $updatedQty = $vaccine->quantity + $quantityDifference;
            $vaccine->update(['quantity' => $updatedQty]);

            return response()->json([
                'message' => 'Statement updated successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $statement = Ministry_statement_stock_vaccine::find($id);

            if (!$statement) {
                return response()->json([
                    'message' => 'Statement not found',
                ], 404);
            }

            $vaccine = Ministry_stock_vaccine::where('vaccine_type_id', $statement->vaccine_type_id)->first();

            // التحقق من ان الحذف لن يؤدي الى قيمة سالبة
            if ($vaccine->quantity < $statement->quantity) {
                return response()->json([
                    'message' => 'Can not delete this vaccine statement now',
                ], 401);
            }

            // تحديث الكمية في جدول اللقاحات
            $newQty = $vaccine->quantity - $statement->quantity;
            $vaccine->update(['quantity' => $newQty]);

            // حذف السجل من جدول بيان اللقاح
            $statement->delete();

            return response()->json([
                'message' => 'Statement deleted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getDateRange()
    {
        try {

            $minDate = Carbon::parse(Ministry_statement_stock_vaccine::min('date'))->toDateString();

            $maxDate = Carbon::parse(Ministry_statement_stock_vaccine::max('date'))->toDateString();

            return response()->json([
                'message' => 'Date range retrieved successfully',
                'min_date' => $minDate,
                'max_date' => $maxDate,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
