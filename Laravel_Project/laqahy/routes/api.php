<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\DirectorateController;
use App\Http\Controllers\GenderController;
use App\Http\Controllers\HealthyCenterAccountController;
use App\Http\Controllers\MinistryStatementStockVaccineController;
use App\Http\Controllers\MinistryStockVaccineController;
use App\Http\Controllers\PermissionTypeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\TechnicalSupportController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// --------------------- Post Routes ------------------------
Route::get('posts/trashed', [PostController::class, 'trashedPosts']);
Route::delete('posts/force-delete/{id}', [PostController::class, 'forceDelete']);
Route::delete('posts/force-delete-all', [PostController::class, 'forceDeleteAll']);
Route::patch('posts/restore/{id}', [PostController::class, 'restore']);
Route::patch('posts/restore-all', [PostController::class, 'restoreAll']);
Route::post('posts/add-post', [PostController::class, 'store']);
Route::get('posts', [PostController::class, 'index']);
Route::patch('posts/update-post/{id}', [PostController::class, 'update']);
Route::delete('posts/delete-post/{id}', [PostController::class, 'destroy']);
// ------------------------------------------------------------

// --------------------- Gender Routes ------------------------
Route::get('genders', [GenderController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Permission Routes ------------------------
Route::get('permissions', [PermissionTypeController::class, 'index']);
// ------------------------------------------------------------

// --------------------- City Routes ------------------------
Route::get('cities', [CityController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Directorate Routes ------------------------
Route::get('directorates/{id}', [DirectorateController::class, 'show']);
// ------------------------------------------------------------

// --------------------- Auth Routes ------------------------
Route::post('auth/register', [AuthController::class, 'register']);
Route::post('auth/login', [AuthController::class, 'login']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::post('users/add-user', [UserController::class, 'store']);
Route::patch('users/update-user/{id}', [UserController::class, 'update']);
Route::get('users/{id}', [UserController::class, 'show']);
Route::delete('users/delete-user/{id}', [UserController::class, 'destroy']);
// ------------------------------------------------------------

// --------------------- Technical Support Routes ------------------------
Route::post('support', [TechnicalSupportController::class, 'sendMessage']);
// ------------------------------------------------------------

// --------------------- Healthy Center Account Routes ------------------------
// Route::post('centers/add-center-account', [HealthyCenterAccountController::class, 'store']);
// ------------------------------------------------------------

// --------------------- Ministry Stock Vaccines Routes ------------------------
Route::get('ministry/vaccines', [MinistryStockVaccineController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Ministry Statement Stock Vaccines Routes ------------------------
Route::post('ministry/vaccines/add-quantity', [MinistryStatementStockVaccineController::class, 'store']);
// ------------------------------------------------------------