<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\DirectorateController;
use App\Http\Controllers\DonorController;
use App\Http\Controllers\GenderController;
use App\Http\Controllers\GeneralController;
use App\Http\Controllers\HealthyCenterController;
use App\Http\Controllers\MinistryStatementStockVaccineController;
use App\Http\Controllers\MinistryStockVaccineController;
use App\Http\Controllers\MotherDataController;
use App\Http\Controllers\OfficeController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PermissionTypeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\TechnicalSupportController;
use App\Http\Controllers\UserController;
use App\Models\Mother_data;
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
/////////////////////////////Ministry//////////////////////////////////////////////////////////////////////////////////////////////////////////
// --------------------- General Routes ------------------------
Route::get('general/home-total-count', [GeneralController::class, 'getTotalCount']);
// ------------------------------------------------------------

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

// --------------------- Office Routes ------------------------
Route::get('offices/centers-count', [OfficeController::class, 'getCentersCount']);
Route::get('offices/registered', [OfficeController::class, 'getRegisteredOffices']);
Route::get('offices/unregistered', [OfficeController::class, 'getUnRegisteredOffices']);
Route::patch('offices/update-office/{id}', [OfficeController::class, 'update']);
// ------------------------------------------------------------

// --------------------- Healthy Center Routes ------------------------
Route::get('centers', [HealthyCenterController::class, 'index']);
Route::get('centers/{id}', [HealthyCenterController::class, 'getCentersByOffice']);
// ------------------------------------------------------------

// --------------------- Directorate Routes ------------------------
Route::get('directorates/{id}', [DirectorateController::class, 'show']);
// ------------------------------------------------------------

// --------------------- Auth Routes ------------------------
Route::post('auth/register', [AuthController::class, 'register']);
Route::post('auth/login', [AuthController::class, 'login']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('users/get-admin/{id}', [UserController::class, 'getAdminData']);
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
Route::get('ministry/vaccines/statement', [MinistryStatementStockVaccineController::class, 'index']);
Route::patch('ministry/vaccines/update-statement/{id}', [MinistryStatementStockVaccineController::class, 'update']);
Route::delete('ministry/vaccines/delete-statement/{id}', [MinistryStatementStockVaccineController::class, 'destroy']);
// ------------------------------------------------------------

// --------------------- Donor Routes ------------------------
Route::post('donors/add-donor', [DonorController::class, 'store']);
Route::get('donors', [DonorController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Order Routes ------------------------
Route::patch('orders/to-in-delivery/{id}', [OrderController::class, 'transferToInDelivery']);
Route::patch('orders/to-cancelled/{id}', [OrderController::class, 'transferToCancelled']);
Route::patch('orders/undo-cancelled/{id}', [OrderController::class, 'undoCancelled']);
Route::get('orders/incoming', [OrderController::class, 'incomingOrders']);
Route::get('orders/in-delivery', [OrderController::class, 'inDeliveryOrders']);
Route::get('orders/delivered', [OrderController::class, 'deliveredOrders']);
Route::get('orders/cancelled', [OrderController::class, 'cancelledOrders']);
// ------------------------------------------------------------

// --------------------- Report Routes ------------------------
Route::get('reports/centers-report/{id}', [ReportController::class, 'generateCentersReport']);
// ------------------------------------------------------------


/////////////////////////////////////////MOBILE Route////////////////////////////////////////////////////////////////////////////


// --------------------- Login Routes ------------------------
Route::post('mobile/login', [AuthController::class, 'mobileLogin']);
// ------------------------------------------------------------



/////////////////////////////////////////MOBILE Route////////////////////////////////////////////////////////////////////////////

// --------------------- Mother Data Routes ------------------------
Route::post('motherData/add-motherData', [MotherDataController::class, 'store']);
// ------------------------------------------------------------
