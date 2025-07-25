<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use App\Models\ChildStatement;
use App\Models\ChildVaccine;
use App\Models\ChildVaccineWithChildDosage;
use App\Models\VaccineStock;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ChildStatementController extends Controller
{

    public function getChildVaccines($child_id)
    {
        try {

            // Fetch all vaccine types with their associated dosages

            //-----------------------------Modified----------------------------------
            $vaccineTypes = ChildVaccine::with('child_dosage_type')->get();
            //---------------------------------------------------------------

            // Initialize the vaccine dosage counts array
            $vaccineDosageCounts = [];

            // Fetch total dosage counts for each vaccine type from child_vaccine_with_child_dosage table
            foreach ($vaccineTypes as $vaccineType) {
                $totalDosageCount = ChildVaccineWithChildDosage::where('child_vaccine_id', $vaccineType->id)->count();

                // Initialize the dosage count for each vaccine type
                $vaccineDosageCounts[$vaccineType->id] =
                    [
                    'child_vaccine_id' => $vaccineType->id,
                    'child_vaccine_type' => $vaccineType->child_vaccine_type,
                    'total_dosage_count' => $totalDosageCount,
                    'child_dosage_count' => 0, // Initialize child dosage count
                ];
            }

            // Fetch the child data along with child statements
            $child = ChildData::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('genders', 'child_data.gender_id', '=', 'genders.id')->select('child_data.*', 'mother_data.mother_name', 'genders.gender_type')->with('child_statement')->find($child_id);

            if (!$child) {
                return response()->json([
                    'message' => 'Child not found',
                ], 404);
            }

            // Calculate the dosage counts for the child
            foreach ($child->child_statement as $statement) {
                if (isset($vaccineDosageCounts[$statement->child_vaccine_id])) {
                    $vaccineDosageCounts[$statement->child_vaccine_id]['child_dosage_count']++;
                }
            }

            $returnDate = ChildStatement::where('child_data_id', $child_id)->max('return_date');

            $now = Carbon::now();
            $birthDate = Carbon::parse($child->child_data_birthDate);
            $diff = $birthDate->diff($now);

            if ($diff->y) {
                $age = $diff->y . ' سنة' . ($diff->m ? ' و ' . $diff->m . ' شهر' : '') . ($diff->d ? ' و ' . $diff->d . ' يوم' : '');
            } elseif ($diff->m) {
                $age = $diff->m . ' شهر' . ($diff->d ? ' و ' . $diff->d . ' يوم' : '');
            } elseif ($diff->d) {
                $age = $diff->d . ' يوم';
            } else {
                $age = 'اليوم';
            }

            // Transform vaccine dosage details array to match the expected structure
            $vaccineDosageDetails = array_values($vaccineDosageCounts);

            // Include child data
            $childData = [
                'id' => $child->id,
                'child_name' => $child->child_data_name,
                'mother_name' => $child->mother_name,
                'child_birthplace' => $child->child_data_birthplace,
                'child_birthDate' => $child->child_data_birthDate,
                'gender_type' => $child->gender_type,
                'return_date' => $returnDate,
                'child_age' => $age,
            ];

            return response()->json([
                'message' => 'Child vaccines retrieved successfully',
                'data' => [
                    'child_data' => $childData,
                    'vaccine_dosage_details' => $vaccineDosageDetails,
                ],
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'child_data_id' => 'required',
                    // 'office_type_id' => 'required',
                    'office_account_id' => 'required',
                    'user_id' => 'required',
                    'date_taking_dose' => 'required',
                    'return_date' => 'required',
                    'visit_type_id' => 'required',
                    'child_vaccine_id' => 'required',
                    'child_dosage_type_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // ------------------------Modified-------------------------------
            $vaccineQty = VaccineStock::where([['office_type_id', 4], ['office_account_id', $request->office_account_id], ['vaccine_category', 'لقاحات الطفل'], ['vaccine_type_id', $request->child_vaccine_id]])->first();
            // -------------------------------------------------------

            $qty = 1;

            if ($qty > $vaccineQty->vaccine_quantity) {

                return response()->json([
                    'message' => 'Vaccine quantity not enough',
                    'quantity' => $vaccineQty->vaccine_quantity,
                ], 405);

            }

            $childStatementExists = ChildStatement::where('child_data_id', $request->child_data_id)->where('visit_type_id', $request->visit_type_id)->where('child_vaccine_id', $request->child_vaccine_id)->where('child_dosage_type_id', $request->child_dosage_type_id)->exists();

            if ($childStatementExists) {
                return response()->json([
                    'message' => 'لقد تم أخذ هذه الجرعة من قبل',
                ], 401);
            }

            // Create record
            $statement = ChildStatement::create([
                'child_data_id' => $request->child_data_id,
                'healthy_center_account_id' => $request->healthy_center_account_id,
                'user_id' => $request->user_id,
                'date_taking_dose' => $request->date_taking_dose,
                'return_date' => $request->return_date,
                'visit_type_id' => $request->visit_type_id,
                'child_vaccine_id' => $request->child_vaccine_id,
                'child_dosage_type_id' => $request->child_dosage_type_id,
            ]);

            $oldQty = $vaccineQty->vaccine_quantity;
            $newQty = $oldQty - $qty;
            $vaccineQty->update(['vaccine_quantity' => $newQty]);

            // Return created record
            return response()->json([
                'message' => 'Child statement created successfully',
                'quantity' => $vaccineQty->vaccine_quantity,
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getChildStatement(string $childId)
    {
        try {

            $childStatement = ChildStatement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->join('healthy_center_accounts', 'child_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('users', 'child_statements.user_id', '=', 'users.id')->join('visit_types', 'child_statements.visit_type_id', '=', 'visit_types.id')->join('child_vaccines', 'child_statements.child_vaccine_id', '=', 'child_vaccines.id')->join('child_dosage_types', 'child_statements.child_dosage_type_id', '=', 'child_dosage_types.id')->select('child_statements.*', 'child_data.child_data_name', 'healthy_center_accounts.healthy_center_account_name', 'users.user_name', 'visit_types.visit_period', 'child_vaccines.child_vaccine_type', 'child_dosage_types.child_dosage_type')->where('child_statements.child_data_id', $childId)->get();

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

    public function destroy(string $childId)
    {
        try {

            $DeletedStatement = ChildStatement::find($childId);

            if (!$DeletedStatement) {
                return response()->json([
                    'message' => 'Child statement not found',
                ], 404);
            }

            $DeletedStatement->delete();

            return response()->json([
                'message' => 'Child statement data deleted successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function printChildStatementData(string $childDataId, string $visitTypeId, string $vaccineTypeId, string $childDosageType, )
    {
        try {

            $childStatement = ChildStatement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->join('healthy_center_accounts', 'child_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('users', 'child_statements.user_id', '=', 'users.id')->join('visit_types', 'child_statements.visit_type_id', '=', 'visit_types.id')->join('child_vaccines', 'child_statements.child_vaccine_id', '=', 'child_vaccines.id')->join('child_dosage_types', 'child_statements.child_dosage_type_id', '=', 'child_dosage_types.id')->select('child_statements.*', 'child_data.child_data_name', 'healthy_center_accounts.healthy_center_account_name', 'users.user_name', 'visit_types.visit_period', 'child_vaccines.child_vaccine_type', 'child_dosage_types.child_dosage_type')->where('child_statements.child_data_id', $childDataId)->where('child_statements.visit_type_id', $visitTypeId)->where('child_statements.child_vaccine_id', $vaccineTypeId)->where('child_statements.child_dosage_type_id', $childDosageType)->get();

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

}
