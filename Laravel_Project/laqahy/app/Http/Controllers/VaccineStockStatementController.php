<?php

namespace App\Http\Controllers;

use App\Models\VaccineStock;
use App\Models\VaccineStockStatement;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VaccineStockStatementController extends Controller
{
    /**
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------- This Page Was Modified By Elias --------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     */
    public function fetchVaccinesStatement(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                    'vaccine_category' => 'required',
                ]
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $vaccineStatement = VaccineStockStatement::join($request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines' : 'child_vaccines', 'vaccine_stock_statements.vaccine_type_id', '=', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.id' : 'child_vaccines.id')->join('donors', 'vaccine_stock_statements.donor_id', '=', 'donors.id')->select('vaccine_stock_statements.*', $request->vaccine_category == 'لقاحات الام' ? 'mother_vaccines.mother_vaccine_type' : 'child_vaccines.child_vaccine_type', 'donors.donor_name')->where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->orderBy('vaccine_stock_statements.id', 'desc')->get();

            return response()->json([
                'message' => 'Vaccines statement retrieved successfully',
                'data' => $vaccineStatement,
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
                    'office_account_id' => 'required',
                    'office_type_id' => 'required',
                    'vaccine_statement_quantity' => 'required',
                    'vaccine_category' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            if ($request->office_type_id == 1) {

                $validator = Validator::make(
                    $request->all(),
                    [
                        'donor_id' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

            }

            $vaccineStatement = VaccineStockStatement::create([
                'vaccine_type_id' => $request->vaccine_type_id,
                'office_account_id' => $request->office_account_id,
                'office_type_id' => $request->office_type_id,
                'vaccine_statement_quantity' => $request->vaccine_statement_quantity,
                'donor_id' => $request->office_type_id == 1 ? $request->donor_id : null,
                'vaccine_category' => $request->vaccine_category,
            ]);

            $vaccineQty = VaccineStock::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id], ['vaccine_category', $request->vaccine_category], ['vaccine_type_id', $request->vaccine_type_id]])->first();

            $newQty = $vaccineQty->vaccine_quantity + $request->vaccine_statement_quantity;
            $vaccineQty->update([
                'vaccine_quantity' => $newQty,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Vaccine statement created successfully',
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
                    'vaccine_statement_quantity' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            if ($request->office_type_id == 1) {

                $validator = Validator::make(
                    $request->all(),
                    [
                        'donor_id' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

            }

            $vaccineStatement = VaccineStockStatement::find($id);

            if (!$vaccineStatement) {
                return response()->json([
                    'message' => 'Statement not found',
                ], 404);
            }

            $oldQty = $vaccineStatement->vaccine_statement_quantity;
            $newQty = $request->vaccine_statement_quantity;
            $quantityDifference = $newQty - $oldQty;

            $vaccine = VaccineStock::where('vaccine_type_id', $vaccineStatement->vaccine_type_id)->first();

            // التحقق من ان التحديث لن يؤدي الى قيمة سالبة
            if ($vaccine->vaccine_quantity + $quantityDifference < 0) {
                return response()->json([
                    'message' => 'Can not update this vaccine statement now',
                ], 401);
            }

            if ($request->office_type_id == 1) {
                // تحديث الكمية في جدول بيان اللقاح
                $vaccineStatement->update(['donor_id' => $request->donor_id, 'vaccine_statement_quantity' => $newQty]);
            } else {
                // تحديث الكمية في جدول بيان اللقاح
                $vaccineStatement->update(['vaccine_statement_quantity' => $newQty]);
            }

            // تحديث الكمية في جدول اللقاحات
            $updatedQty = $vaccine->vaccine_statement_quantity + $quantityDifference;
            $vaccine->update(['vaccine_quantity' => $updatedQty]);

            return response()->json([
                'message' => 'Vaccine statement updated successfully',
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

            $vaccineStatement = VaccineStockStatement::find($id);

            if (!$vaccineStatement) {
                return response()->json([
                    'message' => 'Statement not found',
                ], 404);
            }

            $vaccine = VaccineStock::where('vaccine_type_id', $vaccineStatement->vaccine_type_id)->first();

            // التحقق من ان الحذف لن يؤدي الى قيمة سالبة
            if ($vaccine->vaccine_quantity < $vaccineStatement->vaccine_statement_quantity) {
                return response()->json([
                    'message' => 'Can not delete this vaccine statement now',
                ], 401);
            }

            // تحديث الكمية في جدول اللقاحات
            $newQty = $vaccine->vaccine_quantity - $vaccineStatement->vaccine_statement_quantity;
            $vaccine->update(['vaccine_quantity' => $newQty]);

            // حذف السجل من جدول بيان اللقاح
            $vaccineStatement->delete();

            return response()->json([
                'message' => 'Vaccine statement deleted successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getDateRange(Request $request)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $minDate = Carbon::parse(VaccineStockStatement::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->min('vaccine_statement_date'))->toDateString();

            $maxDate = Carbon::parse(VaccineStockStatement::where([['office_type_id', $request->office_type_id], ['office_account_id', $request->office_account_id]])->min('vaccine_statement_date'))->toDateString();

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
