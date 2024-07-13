<?php

namespace App\Http\Controllers;

use App\Models\Child_data;
use App\Models\Child_statement;
use App\Models\Vaccine_type;
use App\Models\Vaccines_with_dosage;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;

class ChildStatementController extends Controller
{

    public function getChildVaccine($child_id)
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

            $age = $diff->days;

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
}
