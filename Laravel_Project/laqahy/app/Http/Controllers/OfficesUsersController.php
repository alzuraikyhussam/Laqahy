<?php

namespace App\Http\Controllers;

use App\Models\Offices_users;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OfficesUsersController extends Controller
{

    public function addUser(Request $request)
    {
        try {
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
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $userExists = User::where('office_account_id', $request->office_account_id)
                ->where(function ($query) use ($request) {
                    $query->where('user_account_name', $request->user_account_name)
                        ->orWhere('user_name', $request->user_name);
                })->exists();

            if ($userExists) {
                return response()->json([
                    'message' => 'This user already exists',
                ], 401);
            }

            // Create record
            $user = User::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'office_type_id' => $request->office_type_id,
                'office_account_id' => $request->office_account_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'User created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function showUser($id)
    {
        try {
            $user = User::join('permission_types', 'users.permission_type_id', '=', 'permission_types.id')->join('genders', 'offices_users.gender_id', '=', 'genders.id')->join('city_office_accounts', 'users.office_account_id', '=', 'city_office_accounts.id')->select('users.*', 'genders.gender_type', 'city_office_accounts.city_office_account_name', 'permission_types.permission_type')->where('users.office_account_id', $id)->get();
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

    public function updateUser(Request $request, string $id)
    {
        try {
            $user = User::find($id);

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            // التحقق من وجود اسم المستخدم الجديد في المكتب المحدد إذا تم تغييره
            if ($request->user_account_name !== $user->user_account_name) {
                $userExists = User::where('office_account_id', $request->office_account_id)
                    ->where('user_account_name', $request->user_account_name)
                    ->exists();
                if ($userExists) {
                    return response()->json([
                        'message' => 'This username already exists',
                    ], 401);
                }
            }

            // التحقق من وجود اسم الموظف الجديد في المكتب المحدد إذا تم تغييره
            if ($request->user_name !== $user->user_name) {
                $userExists = User::where('office_account_id', $request->office_account_id)
                    ->where('user_name', $request->user_name)
                    ->exists();
                if ($userExists) {
                    return response()->json([
                        'message' => 'This name already exists',
                    ], 401);
                }
            }

            $user->update($request->all());
            return response()->json([
                'message' => 'User updated successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function destroyUser($id)
    {
        try {
            $user = User::find($id);
            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            // $user->delete();
            $user->update(['deleted_at' => Carbon::now()]);

            return response()->json([
                'message' => 'User deleted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getAdminData(Request $request)
    {
        try {
            $admin = User::join('permission_types', 'users.permission_type_id', '=', 'permission_types.id')->join('genders', 'users.gender_id', '=', 'genders.id')->join('city_office_accounts', 'users.office_account_id', '=', 'city_office_accounts.id')->select('users.*', 'genders.gender_type', 'city_office_accounts.city_office_account_name', 'permission_types.permission_type')->where('users.office_account_id', $request->office_account_id)->where('users.id', $request->admin_id)->first();
            return response()->json([
                'message' => 'Admin data retrieved successfully',
                'data' => $admin,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    ///////////////////////////////// Offices ////////////////////////////////

    public function officeShowUser($id)
    {
        try {
            $user = User::join('permission_types', 'users.permission_type_id', '=', 'permission_types.id')->join('genders', 'users.gender_id', '=', 'genders.id')->join('city_office_accounts', 'users.office_account_id', '=', 'city_office_accounts.id')->select('users.*', 'genders.gender_type', 'city_office_accounts.city_office_account_name', 'permission_types.permission_type')->where('users.office_account_id', $id)->get();
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

    public function officeAddUser(Request $request)
    {
        try {
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
                    'office_type_id' => 'required',
                    'office_account_id' => 'required',
                ],
            );
            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $userExists = User::where('office_account_id', $request->office_account_id)
                ->where(function ($query) use ($request) {
                    $query->where('user_account_name', $request->user_account_name)
                        ->orWhere('user_name', $request->user_name);
                })->exists();

            if ($userExists) {
                return response()->json([
                    'message' => 'This user already exists',
                ], 401);
            }

            // Create record
            $user = User::create([
                'user_name' => $request->user_name,
                'user_phone' => $request->user_phone,
                'user_address' => $request->user_address,
                'user_birthDate' => $request->user_birthDate,
                'user_account_name' => $request->user_account_name,
                'user_account_password' => $request->user_account_password,
                'gender_id' => $request->gender_id,
                'permission_type_id' => $request->permission_type_id,
                'office_type_id' => $request->office_type_id,
                'office_account_id' => $request->office_account_id,
            ]);

            // Return created record
            return response()->json([
                'message' => 'User created successfully',
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),

            ], 500);
        }
    }

    public function officeUpdateUser(Request $request, string $id)
    {
        try {
            $user = User::find($id);

            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            // التحقق من وجود اسم المستخدم الجديد في المكتب المحدد إذا تم تغييره
            if ($request->user_account_name !== $user->user_account_name) {
                $userExists = User::where('office_account_id', $request->office_account_id)
                    ->where('user_account_name', $request->user_account_name)
                    ->exists();
                if ($userExists) {
                    return response()->json([
                        'message' => 'This username already exists',
                    ], 401);
                }
            }

            // التحقق من وجود اسم الموظف الجديد في المكتب المحدد إذا تم تغييره
            if ($request->user_name !== $user->user_name) {
                $userExists = User::where('office_account_id', $request->office_account_id)
                    ->where('user_name', $request->user_name)
                    ->exists();
                if ($userExists) {
                    return response()->json([
                        'message' => 'This name already exists',
                    ], 401);
                }
            }

            $user->update($request->all());
            return response()->json([
                'message' => 'User updated successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeDestroyUser(string $id)
    {
        try {
            $user = User::find($id);
            if (!$user) {
                return response()->json([
                    'message' => 'User not found',
                ], 404);
            }

            // $user->delete();
            $user->update(['deleted_at' => Carbon::now()]);

            return response()->json([
                'message' => 'User deleted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function officeGetAdminData(Request $request)
    {
        try {
            $admin = User::join('permission_types', 'users.permission_type_id', '=', 'permission_types.id')->join('genders', 'users.gender_id', '=', 'genders.id')->join('city_office_accounts', 'users.office_account_id','=', 'city_office_accounts.id')->select('users.*', 'genders.gender_type', 'city_office_accounts.city_office_account_name', 'permission_types.permission_type')->where('users.office_account_id', $request->office_account_id)->where('users.id', $request->admin_id)->first();
            return response()->json([
                'message' => 'Admin data retrieved successfully',
                'data' => $admin,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
