<?php

namespace App\Http\Controllers;

use App\Models\ChildData;
use App\Models\ChildVaccine;
use App\Models\CityOfficeAccount;
use App\Models\DirectorateOfficeAccount;
use App\Models\HealthyCenterAccount;
use App\Models\MotherData;
use App\Models\MotherStatement;
use App\Models\MotherVaccine;
use App\Models\User;
use App\Models\VaccineStock;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{

    public function register(Request $request)
    {
        try {

            $office = null;
            $user = null;

            if ($request->office_type_id == 1) { // مكتب وزارة
                $validator = Validator::make(
                    $request->all(),
                    [
                        'user_name' => 'required',
                        'user_phone' => 'required',
                        'user_address' => 'required',
                        'user_birthDate' => 'required',
                        'user_account_name' => 'required',
                        'user_account_password' => 'required',
                        'gender_id' => 'required',
                        'permission_type_id' => 'required',
                        'city_office_account_name' => 'required', //---
                        'city_office_account_phone' => 'required', //---
                        'city_office_account_address' => 'required', //---
                        'city_id' => 'required',
                        'office_type_id' => 'required', //---
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $office = CityOfficeAccount::create([ //---
                    'city_office_account_name' => $request->city_office_account_name,
                    'city_office_account_address' => $request->city_office_account_address,
                    'city_office_account_phone' => $request->city_office_account_phone,
                    'office_type_id' => $request->office_type_id,
                    'city_id' => $request->city_id,
                ]);

                $user = User::create([
                    'user_name' => $request->user_name,
                    'user_phone' => $request->user_phone,
                    'user_address' => $request->user_address,
                    'user_birthDate' => $request->user_birthDate,
                    'user_account_name' => $request->user_account_name,
                    'user_account_password' => $request->user_account_password,
                    'gender_id' => $request->gender_id,
                    'permission_type_id' => $request->permission_type_id,
                    'office_type_id' => $office->office_type_id, //---
                    'office_account_id' => $office->id, //---
                ]);

            } else if ($request->office_type_id == 2) { // مكتب محافظة

                $validator = Validator::make(
                    $request->all(),
                    [
                        'user_name' => 'required',
                        'user_phone' => 'required',
                        'user_address' => 'required',
                        'user_birthDate' => 'required',
                        'user_account_name' => 'required',
                        'user_account_password' => 'required',
                        'gender_id' => 'required',
                        'permission_type_id' => 'required',
                        'city_office_account_id' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $office = CityOfficeAccount::where('id', $request->city_office_account_id)->first();

                $user = User::create([
                    'user_name' => $request->user_name,
                    'user_phone' => $request->user_phone,
                    'user_address' => $request->user_address,
                    'user_birthDate' => $request->user_birthDate,
                    'user_account_name' => $request->user_account_name,
                    'user_account_password' => $request->user_account_password,
                    'gender_id' => $request->gender_id,
                    'permission_type_id' => $request->permission_type_id,
                    'office_type_id' => $office->office_type_id, //---
                    'office_account_id' => $office->id, //---
                ]);

                $office->update(['setup_code' => null]);

            } else if ($request->office_type_id == 3) { // مكتب مديرية

                $validator = Validator::make(
                    $request->all(),
                    [
                        'user_name' => 'required',
                        'user_phone' => 'required',
                        'user_address' => 'required',
                        'user_birthDate' => 'required',
                        'user_account_name' => 'required',
                        'user_account_password' => 'required',
                        'gender_id' => 'required',
                        'permission_type_id' => 'required',
                        'directorate_office_account_id' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $office = DirectorateOfficeAccount::where('id', $request->directorate_office_account_id)->first();

                $user = User::create([
                    'user_name' => $request->user_name,
                    'user_phone' => $request->user_phone,
                    'user_address' => $request->user_address,
                    'user_birthDate' => $request->user_birthDate,
                    'user_account_name' => $request->user_account_name,
                    'user_account_password' => $request->user_account_password,
                    'gender_id' => $request->gender_id,
                    'permission_type_id' => $request->permission_type_id,
                    'office_type_id' => $office->office_type_id, //---
                    'office_account_id' => $office->id, //---
                ]);

                $office->update(['setup_code' => null]);

            } else if ($request->office_type_id == 4) { // مركز صحي

                $validator = Validator::make(
                    $request->all(),
                    [
                        'user_name' => 'required',
                        'user_phone' => 'required',
                        'user_address' => 'required',
                        'user_birthDate' => 'required',
                        'user_account_name' => 'required',
                        'user_account_password' => 'required',
                        'gender_id' => 'required',
                        'permission_type_id' => 'required',
                        'healthy_center_account_id' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $office = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.id', $request->healthy_center_account_id)->first();

                $user = User::create([
                    'user_name' => $request->user_name,
                    'user_phone' => $request->user_phone,
                    'user_address' => $request->user_address,
                    'user_birthDate' => $request->user_birthDate,
                    'user_account_name' => $request->user_account_name,
                    'user_account_password' => $request->user_account_password,
                    'gender_id' => $request->gender_id,
                    'permission_type_id' => $request->permission_type_id,
                    'office_type_id' => $office->office_type_id, //---
                    'office_account_id' => $office->id, //---
                ]);

                $office->update(['setup_code' => null]);

            } else {
                return response()->json([
                    'message' => 'Sorry, something is wrong',
                ], 404);
            }

            $mother_vaccines = MotherVaccine::all(); //---
            $child_vaccines = ChildVaccine::all(); //---

            foreach ($mother_vaccines as $vaccine) { //---
                VaccineStock::create([ //---
                    'vaccine_type_id' => $vaccine->id,
                    'office_type_id' => $request->office_type_id, //---
                    'office_account_id' => $office->id, //---
                    'vaccine_category' => 'لقاحات الام', //---
                    'quantity' => 0,
                ]);
            }
            //---
            foreach ($child_vaccines as $vaccine) {
                VaccineStock::create([
                    'vaccine_type_id' => $vaccine->id,
                    'office_type_id' => $request->office_type_id,
                    'office_account_id' => $office->id,
                    'vaccine_category' => 'لقاحات الطفل',
                    'quantity' => 0,
                ]);
            }
            //---

            // إنشاء توكن Sanctum
            $token = $user->createToken('Office Personal Access Token')->plainTextToken;

            return response()->json([
                'message' => 'Office account with admin account are created successfully',
                'token' => $token,
                'user' => $user,
                'office' => $office,
            ], 201);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function login(Request $request, $office_id = 0)
    {
        try {

            $validator = Validator::make(
                $request->all(),
                [
                    'user_account_name' => 'required',
                    'user_account_password' => 'required',
                    'office_type_id' => 'required', //---
                ],
            );

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $user = User::where('office_type_id', $request->office_type_id)->where('user_account_name', $request->user_account_name)->first(); //---

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            if ($office_id != 0) {
                if ($office_id != $user->office_account_id) { //---
                    return response()->json([
                        'message' => 'User not found in this office',
                    ], 402);
                }
            }

            if (!($request->user_account_password === $user->user_account_password)) {
                return response()->json([
                    'message' => 'Invalid password',
                ], 401);
            }

            $minDate = Carbon::parse(User::where([['office_type_id', $user->office_type_id], ['office_account_id', $user->office_account_id]])->min('created_at'))->toDateString(); //---

            $admin = User::where([ //---
                ['office_account_id', $user->office_account_id], //---
                ['permission_type_id', 1],
                ['created_at', $minDate], //---
            ])->first();

            if ($request->office_type_id == 1 || $request->office_type_id == 2) {

                $office = CityOfficeAccount::where('id', $user->office_account_id)->first(); //---

            } else if ($request->office_type_id == 3) { // مكتب مديرية

                $office = DirectorateOfficeAccount::where('id', $user->office_account_id)->first(); //---

            } else if ($request->office_type_id == 4) { // مركز صحي

                $office = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.id', $user->office_account_id)->first();

            } else {

                return response()->json([
                    'message' => 'Sorry, something is wrong',
                ], 404);

            }

            // إنشاء توكن Sanctum
            $token = $user->createToken('Office Personal Access Token')->plainTextToken;

            return response()->json([
                'message' => 'Login successfully',
                'token' => $token,
                'user' => $user,
                'office' => $office,
                'admin' => $admin,
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function verifySetupCode(Request $request) //---
    {
        try {

            //---
            $office = null;

            if ($request->office_type_id == 2) { // مكتب محافظة

                $office = CityOfficeAccount::where([['office_type_id', $request->office_type_id], ['setup_code', $request->setup_code]])->first(); //---

            } else if ($request->office_type_id == 3) { // مكتب مديرية

                $office = DirectorateOfficeAccount::where('setup_code', $request->setup_code)->first(); //---

            } else if ($request->office_type_id == 4) { // مركز صحي

                $office = HealthyCenterAccount::where('setup_code', $request->setup_code)->first(); //---

            } else {

                return response()->json([
                    'message' => 'Sorry, something is wrong',
                ], 404);

            }
            // ---

            if (!$office) {
                return response()->json([
                    'message' => 'Office not found',
                ], 404);
            }

            return response()->json([
                'message' => 'Office retrieved successfully',
                'office' => $office,
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // public function officeRegister(Request $request)
    // {
    //     try {
    //         $validator = Validator::make(
    //             $request->all(),
    //             [
    //                 'user_name' => 'required',
    //                 'user_phone' => 'required',
    //                 'user_address' => 'required',
    //                 'user_birthDate' => 'required',
    //                 'user_account_name' => 'required',
    //                 'user_account_password' => 'required',
    //                 'gender_id' => 'required',
    //                 'permission_type_id' => 'required',
    //                 'office_id' => 'required',
    //             ],
    //         );

    //         if ($validator->fails()) {
    //             return response()->json([
    //                 'message' => $validator->errors(),
    //             ], 400);
    //         }

    //         $office = Office::where('id', $request->office_id)->first();

    //         $user = Offices_users::create([
    //             'user_name' => $request->user_name,
    //             'user_phone' => $request->user_phone,
    //             'user_address' => $request->user_address,
    //             'user_birthDate' => $request->user_birthDate,
    //             'user_account_name' => $request->user_account_name,
    //             'user_account_password' => $request->user_account_password,
    //             'gender_id' => $request->gender_id,
    //             'permission_type_id' => $request->permission_type_id,
    //             'office_id' => $request->office_id,
    //         ]);

    //         $office->update(['create_account_code' => null]);

    //         $vaccines = VaccineType::all();

    //         foreach ($vaccines as $vaccine) {
    //             Office_stock_vaccine::create([
    //                 'office_id' => $office->id,
    //                 'vaccine_type_id' => $vaccine->id,
    //                 'quantity' => 0,
    //             ]);
    //         }

    //         // إنشاء توكن Sanctum
    //         $token = $user->createToken('Office Personal Access Token')->plainTextToken;

    //         return response()->json([
    //             'message' => 'Office account with admin account are created successfully',
    //             'token' => $token,
    //             'user' => $user,
    //             'office' => $office,
    //         ], 201);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    /////////////////////////////// Centers ////////////////////////////////

    // public function centerCheckVerificationCode($code)
    // {
    //     try {

    //         $center = Healthy_center::where('create_account_code', $code)->first();

    //         if (!$center) {
    //             return response()->json([
    //                 'message' => 'Center not found',
    //             ], 404);
    //         }

    //         return response()->json([
    //             'message' => 'Center retrieved successfully',
    //             'center' => $center,
    //         ], 200);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerRegister(Request $request)
    // {
    //     try {
    //         $validator = Validator::make(
    //             $request->all(),
    //             [
    //                 'user_name' => 'required',
    //                 'user_phone' => 'required',
    //                 'user_address' => 'required',
    //                 'user_birthDate' => 'required',
    //                 'user_account_name' => 'required',
    //                 'user_account_password' => 'required',
    //                 'gender_id' => 'required',
    //                 'permission_type_id' => 'required',
    //                 'healthy_center_id' => 'required',
    //             ],
    //         );

    //         if ($validator->fails()) {
    //             return response()->json([
    //                 'message' => $validator->errors(),
    //             ], 400);
    //         }

    //         $center = Healthy_center::join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'offices.office_name')->where('healthy_centers.id', $request->healthy_center_id)->first();

    //         $user = User::create([
    //             'user_name' => $request->user_name,
    //             'user_phone' => $request->user_phone,
    //             'user_address' => $request->user_address,
    //             'user_birthDate' => $request->user_birthDate,
    //             'user_account_name' => $request->user_account_name,
    //             'user_account_password' => $request->user_account_password,
    //             'gender_id' => $request->gender_id,
    //             'permission_type_id' => $request->permission_type_id,
    //             'healthy_center_id' => $request->healthy_center_id,
    //         ]);

    //         $center->update(['create_account_code' => null]);

    //         $vaccines = VaccineType::all();

    //         foreach ($vaccines as $vaccine) {
    //             Healthy_centers_stock_vaccine::create([
    //                 'healthy_center_id' => $center->id,
    //                 'vaccine_type_id' => $vaccine->id,
    //                 'quantity' => 0,
    //             ]);
    //         }

    //         // إنشاء توكن Sanctum
    //         $token = $user->createToken('Center Personal Access Token')->plainTextToken;

    //         return response()->json([
    //             'message' => 'Center account with admin account are created successfully',
    //             'token' => $token,
    //             'user' => $user,
    //             'center' => $center,
    //         ], 201);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    // public function centerLogin(Request $request, $center_id = 0)
    // {
    //     try {
    //         $validator = Validator::make(
    //             $request->all(),
    //             [
    //                 'user_account_name' => 'required',
    //                 'user_account_password' => 'required',
    //             ],
    //         );

    //         if ($validator->fails()) {
    //             return response()->json([
    //                 'message' => $validator->errors(),
    //             ], 400);
    //         }

    //         $user = User::where('user_account_name', $request->user_account_name)->first();

    //         if (!$user) {
    //             return response()->json([
    //                 'message' => 'User not found',
    //             ], 404);
    //         }

    //         if ($center_id != 0) {
    //             if ($center_id != $user->healthy_center_id) {
    //                 return response()->json([
    //                     'message' => 'User not found in this center',
    //                 ], 402);
    //             }
    //         }

    //         if (!($request->user_account_password === $user->user_account_password)) {
    //             return response()->json([
    //                 'message' => 'Invalid password',
    //             ], 401);
    //         }

    //         $admin = User::where([
    //             ['permission_type_id', 1],
    //             ['healthy_center_id', $user->healthy_center_id],
    //         ])->first();

    //         $center = Healthy_center::join('offices', 'healthy_centers.office_id', '=', 'offices.id')->select('healthy_centers.*', 'offices.office_name')->where('healthy_centers.id', $user->healthy_center_id)->first();

    //         // إنشاء توكن Sanctum
    //         $token = $user->createToken('Center Personal Access Token')->plainTextToken;

    //         return response()->json([
    //             'message' => 'Login successfully',
    //             'token' => $token,
    //             'user' => $user,
    //             'center' => $center,
    //             'admin' => $admin,
    //         ], 200);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    ///////////////////MOBILE//////////////////////

    public function mobileLogin(Request $request, $office_id = 0)
    {
        try {

            if (ctype_digit($request->username)) {

                // إذا كان أرقام، فإنه معرف الأم (ID)

                $validator = Validator::make(
                    $request->all(),
                    [
                        'mother_identity_num' => 'required',
                        'mother_password' => 'required',
                        'token' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $user = MotherData::where('mother_identity_num', $request->mother_identity_num)->first();

                if (!$user) {
                    return response()->json([
                        'message' => 'User not found',
                    ], 404);
                }

                if (!($request->mother_password === $user->mother_password)) {
                    return response()->json([
                        'message' => 'Invalid password',
                    ], 401);
                }

                $motherData = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_center_accounts.healthy_center_account_name')->where('mother_data.id', $user->id)->first();

                $returnDate = MotherStatement::where('mother_data_id', $motherData->id)->max('return_date');
                $childrenCount = ChildData::where('mother_data_id', $motherData->id)->count();

                // Set token
                $user->fcm_token = $request->token;
                $user->save();

                // إنشاء توكن Sanctum
                $token = $user->createToken('Personal Access Token')->plainTextToken;

                return response()->json([
                    'message' => 'Login successfully',
                    'token' => $token,
                    'user' => $motherData,
                    'return_date' => $returnDate,
                    'children_count' => $childrenCount,
                ], 200);

            } else {

                // إذا كان حروف، فإنه اسم مستخدم العامل الصحي

                $office = null;

                $validator = Validator::make(
                    $request->all(),
                    [
                        'user_account_name' => 'required',
                        'user_account_password' => 'required',
                        'office_type_id' => 'required', //---
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $user = User::where('office_type_id', $request->office_type_id)->where('user_account_name', $request->user_account_name)->first(); //---

                if (!$user) {
                    return response()->json([
                        'message' => 'User not found',
                    ], 404);
                }

                if (!($request->user_account_password === $user->user_account_password)) {
                    return response()->json([
                        'message' => 'Invalid password',
                    ], 401);
                }

                $minDate = Carbon::parse(User::where([['office_type_id', $user->office_type_id], ['office_account_id', $user->office_account_id]])->min('created_at'))->toDateString(); //---

                $admin = User::where([ //---
                    ['office_account_id', $user->office_account_id], //---
                    ['permission_type_id', 1],
                    ['created_at', $minDate], //---
                ])->first();

                if (strpos($request->username, 'min-') === 0 || strpos($request->username, 'ci-') === 0) {

                    $office = CityOfficeAccount::where('id', $user->office_account_id)->first(); //---

                } else if (strpos($request->username, 'dir-') === 0) {

                    $office = DirectorateOfficeAccount::where('id', $user->office_account_id)->first(); //---

                } else if (strpos($request->username, 'hc-') === 0) {

                    $office = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.id', $user->office_account_id)->first();

                }

                // إنشاء توكن Sanctum
                $token = $user->createToken('Office Personal Access Token')->plainTextToken;

                return response()->json([
                    'message' => 'Login successfully',
                    'token' => $token,
                    'user' => $user,
                    'office' => $office,
                    'admin' => $admin,
                ], 200);

            }

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function mobileLoginWithFingerprint(Request $request)
    {
        try {

            if (ctype_digit($request->username)) {

                // إذا كان أرقام، فإنه معرف الأم (ID)

                $validator = Validator::make(
                    $request->all(),
                    [
                        'mother_id' => 'required',
                        'token' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $user = MotherData::find($request->mother_id);

                if (!$user) {
                    return response()->json([
                        'message' => 'User not found',
                    ], 404);
                }

                $motherData = MotherData::join('cities', 'mother_data.city_id', '=', 'cities.id')->join('directorates', 'mother_data.directorate_id', '=', 'directorates.id')->join('healthy_center_accounts', 'mother_data.healthy_center_account_id', '=', 'healthy_center_accounts.id')->select('mother_data.*', 'cities.city_name', 'directorates.directorate_name', 'healthy_center_accounts.healthy_center_account_name')->where('mother_data.id', $user->id)->first();

                $returnDate = MotherStatement::where('mother_data_id', $motherData->id)->max('return_date');
                $childrenCount = ChildData::where('mother_data_id', $motherData->id)->count();

                // Set token
                $user->fcm_token = $request->token;
                $user->save();

                // إنشاء توكن Sanctum
                $token = $user->createToken('Personal Access Token')->plainTextToken;

                return response()->json([
                    'message' => 'Login successfully',
                    'token' => $token,
                    'user' => $motherData,
                    'return_date' => $returnDate,
                    'children_count' => $childrenCount,
                ], 200);

            } else {

                // إذا كان حروف، فإنه اسم مستخدم العامل الصحي

                $office = null;

                $validator = Validator::make(
                    $request->all(),
                    [
                        'office_account_id' => 'required', //---
                        'office_type_id' => 'required', //---
                        'token' => 'required',
                    ],
                );

                if ($validator->fails()) {
                    return response()->json([
                        'message' => $validator->errors(),
                    ], 400);
                }

                $user = User::where('office_type_id', $request->office_type_id)->where('user_account_name', $request->user_account_name)->first(); //---

                if (!$user) {
                    return response()->json([
                        'message' => 'User not found',
                    ], 404);
                }

                if (!($request->user_account_password === $user->user_account_password)) {
                    return response()->json([
                        'message' => 'Invalid password',
                    ], 401);
                }

                $minDate = Carbon::parse(User::where([['office_type_id', $user->office_type_id], ['office_account_id', $user->office_account_id]])->min('created_at'))->toDateString(); //---

                $admin = User::where([ //---
                    ['office_account_id', $user->office_account_id], //---
                    ['permission_type_id', 1],
                    ['created_at', $minDate], //---
                ])->first();

                if (strpos($request->username, 'min-') === 0 || strpos($request->username, 'ci-') === 0) {

                    $office = CityOfficeAccount::where('id', $user->office_account_id)->first(); //---

                } else if (strpos($request->username, 'dir-') === 0) {

                    $office = DirectorateOfficeAccount::where('id', $user->office_account_id)->first(); //---

                } else if (strpos($request->username, 'hc-') === 0) {

                    $office = HealthyCenterAccount::join('directorate_office_accounts', 'healthy_center_accounts.directorate_office_account_id', '=', 'directorate_office_accounts.id')->select('healthy_center_accounts.*', 'directorate_office_accounts.directorate_office_account_name')->where('healthy_center_accounts.id', $user->office_account_id)->first();

                }

                // إنشاء توكن Sanctum
                $token = $user->createToken('Office Personal Access Token')->plainTextToken;

                return response()->json([
                    'message' => 'Login successfully',
                    'token' => $token,
                    'user' => $user,
                    'office' => $office,
                    'admin' => $admin,
                ], 200);

            }

        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
