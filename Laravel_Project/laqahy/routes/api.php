<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChildDataController;
use App\Http\Controllers\ChildDosageTypeController;
use App\Http\Controllers\ChildStatementController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\DirectorateController;
use App\Http\Controllers\DonorController;
use App\Http\Controllers\DosageLevelsController;
use App\Http\Controllers\DosageTypeController;
use App\Http\Controllers\GenderController;
use App\Http\Controllers\GeneralController;
use App\Http\Controllers\HealthyCenterController;
use App\Http\Controllers\HealthyCenterOrderController;
use App\Http\Controllers\HealthyCenterStockVaccineController;
use App\Http\Controllers\MinistryStatementStockVaccineController;
use App\Http\Controllers\MinistryStockVaccineController;
use App\Http\Controllers\MotherDataController;
use App\Http\Controllers\MotherStatement;
use App\Http\Controllers\MotherStatementController;
use App\Http\Controllers\OfficeController;
use App\Http\Controllers\OfficesUsersController;
use App\Http\Controllers\OfficeOrderController;
use App\Http\Controllers\OfficeStockVaccineController;
use App\Http\Controllers\OrderStateController;
use App\Http\Controllers\PermissionTypeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\TechnicalSupportController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\VaccineTypesController;
use App\Http\Controllers\VisitTypeController;
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
Route::get('ministry/general/home-total-count/{office_id}', [GeneralController::class, 'getTotalCount']);
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

// --------------------- Vaccines types Routes ------------------------
Route::get('vaccines', [VaccineTypesController::class, 'getVaccines']);
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
Route::post('ministry/auth/login/{office_id?}', [AuthController::class, 'login']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('ministry/users/get-admin', [OfficesUsersController::class, 'getAdminData']);
Route::post('ministry/users/add-user', [OfficesUsersController::class, 'addUser']);
Route::patch('ministry/users/update-user/{id}', [OfficesUsersController::class, 'updateUser']);
Route::get('ministry/users/{id}', [OfficesUsersController::class, 'showUser']);
Route::delete('ministry/users/delete-user/{id}', [OfficesUsersController::class, 'destroyUser']);
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
Route::get('ministry/orders/date-range', [OfficeOrderController::class, 'getDateRange']);
Route::patch('ministry/orders/approval-order/{id}', [OfficeOrderController::class, 'approvalOrder']);
Route::patch('ministry/orders/reject-order/{id}', [OfficeOrderController::class, 'rejectOrder']);
Route::patch('ministry/orders/undo-reject-order/{id}', [OfficeOrderController::class, 'undoRejectedOrder']);
Route::get('ministry/orders/incoming', [OfficeOrderController::class, 'incomingOrders']);
Route::get('ministry/orders/in-delivery', [OfficeOrderController::class, 'inDeliveryOrders']);
Route::get('ministry/orders/delivered', [OfficeOrderController::class, 'deliveredOrders']);
Route::get('ministry/orders/rejected', [OfficeOrderController::class, 'rejectedOrders']);
// ------------------------------------------------------------

// --------------------- Mother Data Routes ------------------------
Route::get('ministry/mother-data/date-range', [MotherDataController::class, 'getDateRange']);
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
Route::get('offices/auth/register/verify/{code}', [AuthController::class, 'officeCheckVerificationCode']);
Route::post('offices/auth/register', [AuthController::class, 'officeRegister']);
Route::post('offices/auth/login/{office_Id?}', [AuthController::class, 'login']);
// ------------------------------------------------------------

// --------------------- General Routes ------------------------
Route::get('offices/general/home-total-count/{office_id}', [GeneralController::class, 'officesGetTotalCount']);
// ------------------------------------------------------------

// --------------------- Office Stock Vaccines Routes ------------------------
Route::get('offices/vaccines-quantity/{office_id}', [OfficeStockVaccineController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Mother Data Routes ------------------------
Route::get('offices/mother-data/date-range/{office_id}', [MotherDataController::class, 'officeGetDateRange']);
// ------------------------------------------------------------

// --------------------- Healthy Center Routes ------------------------
Route::get('offices/centers/{office_id}', [HealthyCenterController::class, 'officeGetCenters']);
Route::post('offices/centers/add-center/{office_id}', [HealthyCenterController::class, 'officeAddCenterAccount']);
Route::patch('offices/centers/update-center/{office_id}', [HealthyCenterController::class, 'officeUpdateCenterAccount']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('offices/users/get-admin', [OfficesUsersController::class, 'officeGetAdminData']);
Route::post('offices/users/add-user', [OfficesUsersController::class, 'officeAddUser']);
Route::patch('offices/users/update-user/{id}', [OfficesUsersController::class, 'officeUpdateUser']);
Route::get('offices/users/{id}', [OfficesUsersController::class, 'officeShowUser']);
Route::delete('offices/users/delete-user/{id}', [OfficesUsersController::class, 'officeDestroyUser']);
// ------------------------------------------------------------

// --------------------- Health Center Order Routes ------------------------
Route::get('offices/orders/date-range/{office_id}', [HealthyCenterOrderController::class, 'officeGetDateRange']);
// ------------------------------------------------------------

// --------------------- Order Routes ------------------------
Route::post('offices/orders/add-order', [OfficeOrderController::class, 'officeAddOrder']);
Route::get('offices/orders/outgoing/{office_id}', [OfficeOrderController::class, 'officeOutgoingOrders']);
Route::get('offices/orders/incoming/{office_id}', [OfficeOrderController::class, 'officeIncomingOrders']);
Route::get('offices/orders/in-delivery/{office_id}', [OfficeOrderController::class, 'officeInDeliveryOrders']);
Route::get('offices/orders/delivered/{office_id}', [OfficeOrderController::class, 'officeDeliveredOrders']);
Route::get('offices/orders/rejected/{office_id}', [OfficeOrderController::class, 'officeRejectedOrders']);
Route::patch('offices/orders/receiving-confirm', [OfficeOrderController::class, 'officeReceivingConfirmOrder']);
Route::patch('offices/orders/approval-center-order/{id}', [OfficeOrderController::class, 'officeApprovalCenterOrder']);
Route::patch('offices/orders/reject-center-order/{id}', [OfficeOrderController::class, 'officeRejectCenterOrder']);
// ------------------------------------------------------------

// --------------------- Report Routes ------------------------
Route::get('offices/reports/centers-report/{office_id}', [ReportController::class, 'officeGenerateCentersReport']);

Route::get('offices/reports/status-report', [ReportController::class, 'officeGenerateStatusReport']);
Route::get('offices/reports/status-all-centers-report', [ReportController::class, 'officeGenerateStatusInAllCentersReport']);

Route::get('offices/reports/vaccines-qty-report/{office_id}', [ReportController::class, 'officeGetVaccinesQtyReport']);

Route::get('offices/reports/orders-all-report', [ReportController::class, 'officeGenerateAllOrdersReport']);
Route::get('offices/reports/orders-vaccines-centers-report', [ReportController::class, 'officeGenerateAllVaccinesOfAllCentersOrdersReport']);
Route::get('offices/reports/orders-states-centers-report', [ReportController::class, 'officeGenerateAllStatesOfAllCentersOrdersReport']);
Route::get('offices/reports/orders-states-vaccines-report', [ReportController::class, 'officeGenerateAllStatesOfAllVaccinesOrdersReport']);
Route::get('offices/reports/orders-centers-report', [ReportController::class, 'officeGenerateAllCentersOrdersReport']);
Route::get('offices/reports/orders-vaccines-report', [ReportController::class, 'officeGenerateAllVaccinesOrdersReport']);
Route::get('offices/reports/orders-states-report', [ReportController::class, 'officeGenerateAllStatesOrdersReport']);
Route::get('offices/reports/orders-custom-report', [ReportController::class, 'officeGenerateCustomOrdersReport']);
// ------------------------------------------------------------

///////////////////////////////////////// MOBILE Routes ////////////////////////////////////////////////////////////////////////////

// --------------------- Auth Routes ------------------------
Route::post('mobile/auth/login', [AuthController::class, 'mobileLogin']);
// ------------------------------------------------------------

// --------------------- Mother Statement Routes ------------------------
Route::get('mobile/mother-statements/get-mother-dosage/{mother_id}', [MotherStatementController::class, 'getMotherDosage']);
// ------------------------------------------------------------

// --------------------- Child Statement Routes ------------------------
Route::get('mobile/child-statements/get-child-vaccines/{child_id}', [ChildStatementController::class, 'getChildVaccines']);
// ------------------------------------------------------------

// --------------------- Child Data Routes ------------------------
Route::get('mobile/child-data/get-child-data/{mother_id}', [ChildDataController::class, 'getChildren']);
// ------------------------------------------------------------

///////////////////////////////////////// Center Routes ////////////////////////////////////////////////////////////////////////////

// --------------------- Mother Data Routes ------------------------
Route::get('centers/mother-data/date-range/{center_id}', [MotherDataController::class, 'centerGetDateRange']);
Route::post('centers/mother-data/add-mother', [MotherDataController::class, 'store']);
Route::get('centers/mother-data/get-mother-data', [MotherDataController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Mother Statement Routes ------------------------
Route::get('centers/mother-statement/get-mother-statement', [MotherStatementController::class, 'index']);
Route::post('centers/mother-statement/add-mother-statement', [MotherStatementController::class, 'store']);
Route::delete('centers/mother-statement/delete-mother-statement/{motherId}', [MotherStatementController::class, 'destroy']);
// ------------------------------------------------------------

// --------------------- Child Data Routes ------------------------
Route::post('centers/child-data/add-child', [ChildDataController::class, 'store']);
Route::get('centers/child-data/get-child/{motherId}', [ChildDataController::class, 'show']);
// ------------------------------------------------------------

// --------------------- Child Statement Routes ------------------------
Route::post('centers/child-statement/add-child-statement', [ChildStatementController::class, 'store']);
// ------------------------------------------------------------

// --------------------- Auth Routes ------------------------
Route::get('centers/auth/register/verify/{code}', [AuthController::class, 'centerCheckVerificationCode']);
Route::post('centers/auth/register', [AuthController::class, 'centerRegister']);
Route::post('centers/auth/login/{center_Id?}', [AuthController::class, 'centerLogin']);
// ------------------------------------------------------------

// --------------------- User Routes ------------------------
Route::get('centers/users/get-admin', [UserController::class, 'centerGetAdminData']);
Route::post('centers/users/add-user', [UserController::class, 'centerAddUser']);
Route::patch('centers/users/update-user/{id}', [UserController::class, 'centerUpdateUser']);
Route::get('centers/users/{id}', [UserController::class, 'centerShowUser']);
Route::delete('centers/users/delete-user/{id}', [UserController::class, 'centerDestroyUser']);
// ------------------------------------------------------------

// --------------------- General Routes ------------------------
Route::get('centers/general/home-total-count/{center_id}', [GeneralController::class, 'centersGetTotalCount']);

// ------------------------------------------------------------
// --------------------- Dosage Level Routes ------------------------
Route::get('centers/dosage-level', [DosageLevelsController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Dosage Type Routes ------------------------
Route::get('centers/dosage-type/{id}', [DosageTypeController::class, 'show']);
// ------------------------------------------------------------

// --------------------- Health Center Order Routes ------------------------
Route::get('centers/orders/date-range/{center_id}', [HealthyCenterOrderController::class, 'centerGetDateRange']);
// ------------------------------------------------------------

// --------------------- Order Routes ------------------------
Route::post('centers/orders/add-order', [HealthyCenterOrderController::class, 'centerAddOrder']);
Route::get('centers/orders/outgoing/{center_id}', [HealthyCenterOrderController::class, 'centerOutgoingOrders']);
Route::get('centers/orders/in-delivery/{center_id}', [HealthyCenterOrderController::class, 'centerInDeliveryOrders']);
Route::get('centers/orders/delivered/{center_id}', [HealthyCenterOrderController::class, 'centerDeliveredOrders']);
Route::get('centers/orders/rejected/{center_id}', [HealthyCenterOrderController::class, 'centerRejectedOrders']);
Route::patch('centers/orders/receiving-confirm', [HealthyCenterOrderController::class, 'centerReceivingConfirmOrder']);
// ------------------------------------------------------------

// --------------------- Healthy Centers Stock Vaccines Routes ------------------------
Route::get('centers/vaccines-quantity/{center_id}', [HealthyCenterStockVaccineController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Visit Type Routes ------------------------
Route::get('centers/get-visit-type', [VisitTypeController::class, 'index']);
// ------------------------------------------------------------

// --------------------- Vaccines With Visit Routes ------------------------
Route::get('centers/get-vaccine-with-visit-type/{visitTypeId}', [VisitTypeController::class, 'getVaccinesFromVisit']);
// ------------------------------------------------------------

// --------------------- Dosage With Vaccine Routes ------------------------
Route::get('centers/get-dosage-with-vaccine-type/{vaccineTypeId}', [ChildDosageTypeController::class, 'getDosagesFromVaccine']);
// ------------------------------------------------------------

// --------------------- Report Routes ------------------------
Route::get('centers/reports/vaccines-qty-report/{center_id}', [ReportController::class, 'centerGetVaccinesQtyReport']);
Route::get('centers/reports/status-report', [ReportController::class, 'centerGenerateStatusReport']);
Route::get('centers/reports/orders-all-report', [ReportController::class, 'centerGenerateAllOrdersReport']);
Route::get('centers/reports/orders-vaccines-report', [ReportController::class, 'centerGenerateAllVaccinesOrdersReport']);
Route::get('centers/reports/orders-states-report', [ReportController::class, 'centerGenerateAllStatesOrdersReport']);
Route::get('centers/reports/orders-custom-report', [ReportController::class, 'centerGenerateCustomOrdersReport']);
// ------------------------------------------------------------
