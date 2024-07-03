<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChildDataController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\DirectorateController;
use App\Http\Controllers\DonorController;
use App\Http\Controllers\DosageLevelsController;
use App\Http\Controllers\DosageTypeController;
use App\Http\Controllers\GenderController;
use App\Http\Controllers\GeneralController;
use App\Http\Controllers\HealthyCenterController;
use App\Http\Controllers\MinistryStatementStockVaccineController;
use App\Http\Controllers\MinistryStockVaccineController;
use App\Http\Controllers\MotherDataController;
use App\Http\Controllers\OfficeController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\OrderStateController;
use App\Http\Controllers\PermissionTypeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\TechnicalSupportController;
use App\Http\Controllers\UserController;
use App\Models\Dosage_level;
use App\Models\Mother_data;

use App\Models\Ministry_statement_stock_vaccine;
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
Route::get('ministry/general/home-total-count', [GeneralController::class, 'getTotalCount']);
// ------------------------------------------------------------

// --------------------- Post Routes ------------------------
Route::get('ministry/posts/trashed', [PostController::class, 'trashedPosts']);
Route::delete('ministry/posts/force-delete/{id}', [PostController::class, 'forceDelete']);
Route::delete('ministry/posts/force-delete-all', [PostController::class, 'forceDeleteAll']);
Route::patch('ministry/posts/restore/{id}', [PostController::class, 'restore']);
Route::patch('ministry/posts/restore-all', [PostController::class, 'restoreAll']);
Route::post('ministry/posts/add-post', [PostController::class, 'store']);
Route::get('ministry/posts', [PostController::class, 'index']);
Route::patch('ministry/posts/update-post/{id}', [PostController::class, 'update']);
Route::delete('ministry/posts/delete-post/{id}', [PostController::class, 'destroy']);
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

// --------------------- Order State Routes ------------------------
Route::get('order-states', [OrderStateController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Office Routes ------------------------
Route::get('ministry/offices/centers-count', [OfficeController::class, 'getCentersCount']);
Route::get('ministry/offices/registered', [OfficeController::class, 'getRegisteredOffices']);
Route::get('ministry/offices/unregistered', [OfficeController::class, 'getUnRegisteredOffices']);
Route::patch('ministry/offices/update-office/{id}', [OfficeController::class, 'update']);
// ------------------------------------------------------------

// --------------------- Healthy Center Routes ------------------------
Route::get('ministry/centers', [HealthyCenterController::class, 'index']);
Route::get('ministry/centers/{id}', [HealthyCenterController::class, 'getCentersByOffice']);
// ------------------------------------------------------------

// --------------------- Directorate Routes ------------------------
Route::get('directorates/{id}', [DirectorateController::class, 'show']);
// ------------------------------------------------------------

// --------------------- Auth Routes ------------------------
Route::post('ministry/auth/register', [AuthController::class, 'register']);
Route::post('ministry/auth/login/{center_id?}', [AuthController::class, 'login']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('ministry/users/get-admin/{id}', [UserController::class, 'getAdminData']);
Route::post('ministry/users/add-user', [UserController::class, 'store']);
Route::patch('ministry/users/update-user/{id}', [UserController::class, 'update']);
Route::get('ministry/users/{id}', [UserController::class, 'show']);
Route::delete('ministry/users/delete-user/{id}', [UserController::class, 'destroy']);
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
Route::get('ministry/vaccines/date-range', [MinistryStatementStockVaccineController::class, 'getDateRange']);
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
Route::get('ministry/orders/date-range', [OrderController::class, 'getDateRange']);
Route::patch('ministry/orders/to-in-delivery/{id}', [OrderController::class, 'transferToInDelivery']);
Route::patch('ministry/orders/to-cancelled/{id}', [OrderController::class, 'transferToCancelled']);
Route::patch('ministry/orders/undo-cancelled/{id}', [OrderController::class, 'undoCancelled']);
Route::get('ministry/orders/incoming', [OrderController::class, 'incomingOrders']);
Route::get('ministry/orders/in-delivery', [OrderController::class, 'inDeliveryOrders']);
Route::get('ministry/orders/delivered', [OrderController::class, 'deliveredOrders']);
Route::get('ministry/orders/cancelled', [OrderController::class, 'cancelledOrders']);
// ------------------------------------------------------------

// --------------------- Mother Data Routes ------------------------
Route::get('ministry/mothers/date-range', [MotherDataController::class, 'getDateRange']);
// ------------------------------------------------------------

// --------------------- Report Routes ------------------------
Route::get('ministry/reports/centers-report/{id}', [ReportController::class, 'generateCentersReport']);

Route::get('ministry/reports/status-report', [ReportController::class, 'generateStatusReport']);
Route::get('ministry/reports/status-all-offices-report', [ReportController::class, 'generateStatusInAllOfficesReport']);
Route::get('ministry/reports/status-all-centers-report', [ReportController::class, 'generateStatusInAllCentersReport']);

Route::get('ministry/reports/offices-report', [ReportController::class, 'getOfficesReport']);

Route::get('ministry/reports/vaccines-qty-report', [ReportController::class, 'getVaccinesQtyReport']);

Route::get('ministry/reports/stock/vaccines-all-report', [ReportController::class, 'generateVaccinesStockAllReport']);
Route::get('ministry/reports/stock/vaccines-custom-report', [ReportController::class, 'generateVaccinesStockCustomReport']);
Route::get('ministry/reports/stock/vaccines-specific-donor-report', [ReportController::class, 'generateAllVaccinesStockOfSpecificDonorReport']);
Route::get('ministry/reports/stock/vaccine-all-donors-report', [ReportController::class, 'generateSpecificVaccineStockOfAllDonorsReport']);

Route::get('ministry/reports/orders-all-report', [ReportController::class, 'generateAllOrdersReport']);
Route::get('ministry/reports/orders-vaccines-offices-report', [ReportController::class, 'generateAllVaccinesOfAllOfficesOrdersReport']);
Route::get('ministry/reports/orders-states-offices-report', [ReportController::class, 'generateAllStatesOfAllOfficesOrdersReport']);
Route::get('ministry/reports/orders-states-vaccines-report', [ReportController::class, 'generateAllStatesOfAllVaccinesOrdersReport']);
Route::get('ministry/reports/orders-offices-report', [ReportController::class, 'generateAllOfficesOrdersReport']);
Route::get('ministry/reports/orders-vaccines-report', [ReportController::class, 'generateAllVaccinesOrdersReport']);
Route::get('ministry/reports/orders-states-report', [ReportController::class, 'generateAllStatesOrdersReport']);
Route::get('ministry/reports/orders-custom-report', [ReportController::class, 'generateCustomOrdersReport']);
// ------------------------------------------------------------

/////////////////////////////////////// Offices Routes ///////////////////////////////////////////////////////////////////////////////

// --------------------- Auth Routes ------------------------
Route::get('offices/auth/register/verify/{code}', [AuthController::class, 'checkVerificationCode']);
Route::post('offices/auth/register', [AuthController::class, 'officeRegister']);
Route::post('offices/auth/login/{office_Id?}', [AuthController::class, 'officeLogin']);
// ------------------------------------------------------------

// --------------------- General Routes ------------------------
Route::get('offices/general/home-total-count/{office_id}', [GeneralController::class, 'officesGetTotalCount']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('offices/users/get-admin/{id}', [UserController::class, 'officeGetAdminData']);
Route::post('offices/users/add-user', [UserController::class, 'officeAddUser']);
Route::patch('offices/users/update-user/{id}', [UserController::class, 'officeUpdateUser']);
Route::get('offices/users/{id}', [UserController::class, 'officeShowUser']);
Route::delete('offices/users/delete-user/{id}', [UserController::class, 'officeDestroyUser']);
// ------------------------------------------------------------

///////////////////////////////////////// MOBILE Routes ////////////////////////////////////////////////////////////////////////////


// --------------------- Login Routes ------------------------
Route::post('mobile/login', [AuthController::class, 'mobileLogin']);
// ------------------------------------------------------------



///////////////////////////////////////// Center Routes ////////////////////////////////////////////////////////////////////////////

// --------------------- Mother Data Routes ------------------------
Route::get('center/motherData/get-motherData', [MotherDataController::class, 'index']);
Route::post('center/motherData/add-motherData', [MotherDataController::class, 'store']);
// ------------------------------------------------------------

// --------------------- Child Data Routes ------------------------
Route::post('center/childData/add-childData', [ChildDataController::class, 'store']);
// ------------------------------------------------------------

// --------------------- Dosage Levels Routes ------------------------
Route::get('center/Dosage-Level', [DosageLevelsController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Dosage Types Routes ------------------------
Route::get('center/Dosage-type/{id}', [DosageTypeController::class, 'show']);
// ------------------------------------------------------------
