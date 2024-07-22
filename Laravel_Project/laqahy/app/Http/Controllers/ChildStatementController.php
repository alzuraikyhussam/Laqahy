<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use App\Models\Child_data;
use App\Models\Child_statement;
use App\Models\Vaccine_type;
use App\Models\Vaccines_with_dosage;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;

class ChildStatementController extends Controller
{

    public function getChildVaccines($child_id)
    {
        try {

            // Fetch all vaccine types with their associated dosages
            $vaccineTypes = Vaccine_type::with('child_dosage_type')->get();

            // Initialize the vaccine dosage counts array
            $vaccineDosageCounts = [];

            // Fetch total dosage counts for each vaccine type from vaccines_with_dosages table
            foreach ($vaccineTypes as $vaccineType) {
                $totalDosageCount = Vaccines_with_dosage::where('vaccine_type_id', $vaccineType->id)->count();

                // Initialize the dosage count for each vaccine type
                $vaccineDosageCounts[$vaccineType->id] =
                    [
                        'vaccine_type_id' => $vaccineType->id,
                        'vaccine_type' => $vaccineType->vaccine_type,
                        'total_dosage_count' => $totalDosageCount,
                        'child_dosage_count' => 0, // Initialize child dosage count
                    ];
            }

            // Fetch the child data along with child statements
            $child = Child_data::join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->join('genders', 'child_data.gender_id', '=', 'genders.id')->select('child_data.*', 'mother_data.mother_name', 'genders.genders_type')->with('child_statement')->find($child_id);

            if (!$child) {
                return response()->json([
                    'message' => 'Child not found',
                ], 404);
            }

            // Calculate the dosage counts for the child
            foreach ($child->child_statement as $statement) {
                if (isset($vaccineDosageCounts[$statement->vaccine_type_id])) {
                    $vaccineDosageCounts[$statement->vaccine_type_id]['child_dosage_count']++;
                }
            }

            $returnDate = Child_statement::where('child_data_id', $child_id)->max('return_date');
            $now = Carbon::now();
            $birthDate = Carbon::parse($child->child_data_birthDate);
            $diff = $birthDate->diff($now);

            if ($diff->y) {
                $age = $diff->y . ' سنة و ' . $diff->m . ' شهر و ' . $diff->d . ' يوم';
            } elseif ($diff->m >= 1) {
                $age = 'شهر و ' . $diff->d . ' يوم';
            } else {
                $age = $diff->days . 'يوم';
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
                'gender_type' => $child->genders_type,
                'return_date' => $returnDate,
                'child_age' => $age,
            ];

            return response()->json([
                'message' => 'Child vaccines retrieved successfully',
                'data' => [
                    'child_data' => $childData,
                    'vaccine_dosage_details' => $vaccineDosageDetails,
                ]
            ]);

            // $vaccineCount = Vaccine_type::withCount('child_dosage_type')->get();
            // $childStatement = Child_statement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->select('child_statements.*', 'child_data.child_data_name')->where('child_statements.id', $child_id)->get();

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
                    'healthy_center_id' => 'required',
                    'user_id' => 'required',
                    'date_taking_dose' => 'required',
                    'return_date' => 'required',
                    'visit_type_id' => 'required',
                    'vaccine_type_id' => 'required',
                    'child_dosage_type_id' => 'required',

                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $childStatementExists = Child_statement::where('visit_type_id', $request->visit_type_id)->where('vaccine_type_id', $request->vaccine_type_id)->where('child_dosage_type_id', $request->child_dosage_type_id)->exists();

            if ($childStatementExists) {
                return response()->json([
                    'message' => 'لقد تم أخذ هذه الجرعة من قبل',
                ], 401);
            }

            // Create record
            $user = Child_statement::create([
                'child_data_id' => $request->child_data_id,
                'healthy_center_id' => $request->healthy_center_id,
                'user_id' => $request->user_id,
                'date_taking_dose' => $request->date_taking_dose,
                'return_date' => $request->return_date,
                'visit_type_id' => $request->visit_type_id,
                'vaccine_type_id' => $request->vaccine_type_id,
                'child_dosage_type_id' => $request->child_dosage_type_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'Child statement created successfully',
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
            $childStatement = Child_statement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->join('healthy_centers', 'child_statements.healthy_center_id', '=', 'healthy_centers.id')->join('users', 'child_statements.user_id', '=', 'users.id')->join('visit_types', 'child_statements.visit_type_id', '=', 'visit_types.id')->join('vaccine_types', 'child_statements.vaccine_type_id', '=', 'vaccine_types.id')->join('child_dosage_types', 'child_statements.child_dosage_type_id', '=', 'child_dosage_types.id')->select('child_statements.*', 'child_data.child_data_name', 'healthy_centers.healthy_center_name', 'users.user_name','visit_types.visit_period', 'vaccine_types.vaccine_type', 'child_dosage_types.child_dosage_type')->where('child_statements.child_data_id',$childId)->get();
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
            $childDeleteStatement = Child_statement::find($childId);
            if (!$childDeleteStatement) {
                return response()->json([
                    'message' => 'Child Data not found',
                ], 404);
            }

            $childDeleteStatement->delete();

            return response()->json([
                'message' => 'Child Statement Data deleted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

}
