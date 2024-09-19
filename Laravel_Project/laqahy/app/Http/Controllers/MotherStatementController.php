<?php

namespace App\Http\Controllers;

use App\Models\MotherStatement;
use App\Models\VaccineStock;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotherStatementController extends Controller
{
    /*
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------- This Page Was Modified By Elias --------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
     **--------------------------------------------------------------
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
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'mother_data_id' => 'required',
                    'healthy_center_account_id' => 'required',
                    'user_id' => 'required',
                    'date_taking_dose' => 'required',
                    'return_date' => 'required',
                    'mother_vaccine_id' => 'required',
                    'mother_dosage_type_id' => 'required',
                    'dosage_level_id' => 'required',
                    'dosage_level_id' => 'required',
                    'office_account_id' => 'required',
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // ------------------------Modified-------------------------------
            $vaccineQty = VaccineStock::where([['office_type_id', 4], ['office_account_id', $request->office_account_id], ['vaccine_category', 'لقاحات الام'], ['vaccine_type_id', $request->mother_vaccine_id]])->first();
            // -------------------------------------------------------

            $qty = 1;

            if ($qty > $vaccineQty->vaccine_quantity) {

                return response()->json([
                    'message' => 'Vaccine quantity not enough',
                    'quantity' => $vaccineQty->vaccine_quantity,
                ], 405);

            }

            $motherStatementExists = MotherStatement::where('mother_dosage_type_id', $request->mother_dosage_type_id)->where('mother_data_id', $request->mother_data_id)->exists();

            if ($motherStatementExists) {
                return response()->json([
                    'message' => 'لقد تم أخذ هذه الجرعة من قبل',
                ], 401);
            }

            // Create record
            $user = MotherStatement::create([
                'mother_data_id' => $request->mother_data_id,
                'healthy_center_account_id' => $request->healthy_center_account_id,
                'user_id' => $request->user_id,
                'date_taking_dose' => $request->date_taking_dose,
                'return_date' => $request->return_date,
                'mother_vaccine_id' => $request->mother_vaccine_id,
                'mother_dosage_type_id' => $request->mother_dosage_type_id,
                'dosage_level_id' => $request->dosage_level_id,
            ]);

            $oldQty = $vaccineQty->vaccine_quantity;
            $newQty = $oldQty - $qty;
            $vaccineQty->update(['vaccine_quantity' => $newQty]);

            // Return created record
            return response()->json([
                'message' => 'Mother statement created successfully',
                'quantity' => $vaccineQty->vaccine_quantity,
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
    public function show(string $motherId)
    {
        try {

            $motherStatement = MotherStatement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('mother_dosage_types', 'mother_statements.mother_dosage_type_id', '=', 'mother_dosage_types.id')->join('dosage_levels', 'mother_statements.dosage_level_id', '=', 'dosage_levels.id')->join('users', 'mother_statements.user_id', '=', 'users.id')->select('mother_statements.*', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'mother_dosage_types.mother_dosage_type', 'dosage_levels.dosage_level', 'users.user_name')->where('mother_statements.mother_data_id', $motherId)->get();

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
    public function destroy(string $motherId)
    {

        try {

            $motherStatement = MotherStatement::find($motherId);

            if (!$motherStatement) {
                return response()->json([
                    'message' => 'Mother statement not found',
                ], 404);
            }

            $motherStatement->delete();

            return response()->json([
                'message' => 'Mother statement deleted successfully',
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // public function getMotherDosage(string $mother_id)
    // {
    //     try {

    //         $dosageCount = DosageLevel::withCount('mother_dosage_type')->get();
    //         $basicDosageTakenCount = MotherStatement::where('mother_data_id', $mother_id)->where('dosage_level_id', 1)->count();
    //         $refresherDosageTakenCount = MotherStatement::where('mother_data_id', $mother_id)->where('dosage_level_id', 2)->count();

    //         return response()->json([
    //             'message' => 'Mother dosage retrieved successfully',
    //             'data' => [
    //                 'dosage_count' => $dosageCount,
    //                 'basic_dosage_taken_count' => $basicDosageTakenCount,
    //                 'refresher_dosage_taken_count' => $refresherDosageTakenCount,
    //             ],
    //         ]);

    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    public function getMotherDosageData($mother_id)
    {
        try {
            // Retrieve dosage count grouped by vaccine and dosage level
            $dosageCounts = MotherStatement::with(['mother_vaccine', 'mother_dosage_type.dosage_level'])
                ->where('mother_data_id', $mother_id)
                ->get()
                ->groupBy('mother_vaccine.mother_vaccine_type');

            $response = [];

            foreach ($dosageCounts as $vaccineName => $statements) {
                // Use distinct dosage levels to avoid duplicates
                $dosageCountByLevel = $statements->groupBy('mother_dosage_type.dosage_level_id');

                foreach ($dosageCountByLevel as $levelId => $levelStatements) {
                    $response[] = [
                        'mother_vaccine' => [
                            'name' => $vaccineName,
                        ],
                        'dosage_level' => [
                            'name' => $levelStatements->first()->mother_dosage_type->dosage_level->dosage_level, // Correct access to dosage_level
                        ],
                        'dosage_count' => $levelStatements->count(),
                    ];
                }
            }

            return response()->json([
                'message' => 'Mother dosage data retrieved successfully',
                'data' => [
                    'dosage_count_by_level' => $response,
                ],
            ]);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }

        // Result
        // {
        //     "message": "Mother dosage retrieved successfully",
        //     "data": {
        //         "dosage_count_by_level": [
        //             {
        //                 "mother_vaccine": {
        //                     "name": "Polio"
        //                 },
        //                 "dosage_level": {
        //                     "name": "Basic"
        //                 },
        //                 "dosage_count": 3
        //             },
        //             {
        //                 "mother_vaccine": {
        //                     "name": "Polio"
        //                 },
        //                 "dosage_level": {
        //                     "name": "Refresher"
        //                 },
        //                 "dosage_count": 2
        //             },
        //             {
        //                 "mother_vaccine": {
        //                     "name": "Hepatitis B"
        //                 },
        //                 "dosage_level": {
        //                     "name": "Basic"
        //                 },
        //                 "dosage_count": 1
        //             }
        //         ]
        //     }
        // }

        //----------------
        // Flutter Code
//         If you're using GetX architecture in your Flutter application, you can implement a structured approach by creating a controller to manage the state and a view to display the data. Here’s how to set it up:

// ### 1. Create a Model

// First, define a model to represent the dosage data:

// ```dart
// class Dosage {
//   final String vaccineName;
//   final String dosageLevelName;
//   final int dosageCount;

//   Dosage({required this.vaccineName, required this.dosageLevelName, required this.dosageCount});
// }
// ```

// ### 2. Create a Controller

// Create a GetX controller to manage the state and handle API calls:

// ```dart
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class DosageController extends GetxController {
//   var dosageList = <Dosage>[].obs; // Observable list
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     fetchDosageData();
//     super.onInit();
//   }

//   Future<void> fetchDosageData() async {
//     final response = await http.get(Uri.parse('http://your-laravel-api-url.com/api/mother-dosage/{mother_id}'));

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       List<dynamic> dosageData = jsonData['data']['dosage_count_by_level'];

//       dosageList.clear();
//       for (var dosage in dosageData) {
//         dosageList.add(Dosage(
//           vaccineName: dosage['mother_vaccine']['name'],
//           dosageLevelName: dosage['dosage_level']['name'],
//           dosageCount: dosage['dosage_count'],
//         ));
//       }
//       isLoading.value = false; // Stop loading
//     } else {
//       throw Exception('Failed to load dosage data');
//     }
//   }
// }
// ```

// ### 3. Create the View

// Now, create a view that uses the controller to display the data:

// ```dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DosageDataTable extends StatelessWidget {
//   final DosageController dosageController = Get.put(DosageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mother Dosage Data'),
//       ),
//       body: Obx(() {
//         if (dosageController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         // Grouping data by vaccine name
//         Map<String, List<Dosage>> groupedData = {};
//         for (var dosage in dosageController.dosageList) {
//           if (!groupedData.containsKey(dosage.vaccineName)) {
//             groupedData[dosage.vaccineName] = [];
//           }
//           groupedData[dosage.vaccineName]!.add(dosage);
//         }

//         return SingleChildScrollView(
//           child: Column(
//             children: groupedData.entries.map((entry) {
//               String vaccineName = entry.key;
//               List<Dosage> dosageLevels = entry.value;

//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       vaccineName,
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     DataTable(
//                       columns: const <DataColumn>[
//                         DataColumn(label: Text('Dosage Level Name')),
//                         DataColumn(label: Text('Dosage Count')),
//                       ],
//                       rows: dosageLevels.map((dosage) {
//                         return DataRow(cells: [
//                           DataCell(Text(dosage.dosageLevelName)),
//                           DataCell(Text(dosage.dosageCount.toString())),
//                         ]);
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       }),
//     );
//   }
// }
// ```

// ### Summary of the GetX Implementation

// 1. **Model**: The `Dosage` model represents the structure of dosage data.
// 2. **Controller**:
//    - `DosageController` handles fetching data from the API, storing it in an observable list, and managing loading state.
//    - It uses the `onInit` method to fetch data when the controller is initialized.
// 3. **View**:
//    - The `DosageDataTable` widget uses the controller to display the data.
//    - The `Obx` widget listens for changes in the observable properties (like `isLoading` and `dosageList`).
//    - The data is grouped by vaccine name and displayed in separate tables.

// ### Example Result Structure

// When you run the Flutter app, it will show loading indicators while fetching the data, and then display the grouped dosage data in a tabular format, similar to the previous example but now utilizing GetX for state management.

// This approach provides a clean separation of concerns and makes it easier to manage and scale your application.

    }

    public function printMotherStatementData(string $motherId, string $dosageLevel, string $dosageType, string $vaccineName)
    {
        try {
            $motherStatement = MotherStatement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->join('healthy_center_accounts', 'mother_statements.healthy_center_account_id', '=', 'healthy_center_accounts.id')->join('mother_vaccines', 'mother_statements.mother_vaccine_id', '=', 'mother_vaccines.id')->join('mother_dosage_types', 'mother_statements.mother_dosage_type_id', '=', 'mother_dosage_types.id')->join('dosage_levels', 'mother_statements.dosage_level_id', '=', 'dosage_levels.id')->join('users', 'mother_statements.user_id', '=', 'users.id')->select('mother_statements.*', 'mother_data.mother_name', 'healthy_center_accounts.healthy_center_account_name', 'mother_vaccines.mother_vaccine_type', 'mother_dosage_types.mother_dosage_type', 'dosage_levels.dosage_level', 'users.user_name')->where('mother_statements.dosage_level_id', $dosageLevel)->where('mother_statements.mother_vaccine_id', $vaccineName)->where('mother_statements.mother_dosage_type_id', $dosageType)->where('mother_statements.mother_data_id', $motherId)->get();

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
}
