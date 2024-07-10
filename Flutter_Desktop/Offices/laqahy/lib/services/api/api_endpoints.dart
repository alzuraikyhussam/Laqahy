class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // *********************************************

  // --------------- Total Count Endpoints -------------------
  static const String getTotalCount =
      '$baseUrl/offices/general/home-total-count';
  // --------------------------------------------------

  // --------------- Gender Endpoints -------------------
  static const String getGenders = '$baseUrl/genders';
  // --------------------------------------------------

  // --------------- City Endpoints -------------------
  static const String getCities = '$baseUrl/cities';
  // --------------------------------------------------

  // --------------- Directorates Endpoints -------------------
  static const String getDirectorates = '$baseUrl/directorates';
  // --------------------------------------------------

  // --------------- Permission Endpoints -------------------
  static const String getPermissions = '$baseUrl/permissions';
  // --------------------------------------------------

  // --------------- Create Account Verification Endpoints -------------------
  static const String registerVerification =
      '$baseUrl/offices/auth/register/verify';
  // --------------------------------------------------

  // --------------- Register Endpoints -------------------
  static const String register = '$baseUrl/offices/auth/register';
  // --------------------------------------------------

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/offices/auth/login';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------

  // --------------- Vaccines Endpoints -------------------
  static const String getVaccines = '$baseUrl/vaccines';
  // --------------------------------------------------

  // --------------- Office Stock Vaccines Endpoints -------------------
  static const String getVaccinesQuantity =
      '$baseUrl/offices/vaccines-quantity';
  // --------------------------------------------------

  // --------------- Order State Endpoints -------------------
  static const String getOrderStates = '$baseUrl/order-states';
  // --------------------------------------------------

  // --------------- Mother Data Endpoints -------------------
  static const String getMotherDateRange =
      '$baseUrl/offices/mother-data/date-range';
  // --------------------------------------------------

  // --------------- Healthy Center Endpoints -------------------
  static const String getCenters = '$baseUrl/offices/centers';
  static const String addCenterAccount = '$baseUrl/offices/centers/add-center';
  static const String updateCenterAccount =
      '$baseUrl/offices/centers/update-center';
  // --------------------------------------------------

  // --------------- User Endpoints -------------------
  static const String getUsers = '$baseUrl/offices/users';
  static const String getAdmin = '$baseUrl/offices/users/get-admin';
  static const String addUser = '$baseUrl/offices/users/add-user';
  static const String updateUser = '$baseUrl/offices/users/update-user';
  static const String deleteUser = '$baseUrl/offices/users/delete-user';
  // --------------------------------------------------

  // --------------- Order Endpoints -------------------
  static const String getOrdersDateRange = '$baseUrl/offices/orders/date-range';
  static const String addOrder = '$baseUrl/offices/orders/add-order';
  static const String getOutgoingOrders = '$baseUrl/offices/orders/outgoing';
  static const String getIncomingOrders = '$baseUrl/offices/orders/incoming';
  static const String getInDeliveryOrders =
      '$baseUrl/offices/orders/in-delivery';
  static const String getDeliveredOrders = '$baseUrl/offices/orders/delivered';
  static const String getRejectedOrders = '$baseUrl/offices/orders/rejected';
  static const String receivingOrderConfirm =
      '$baseUrl/offices/orders/receiving-confirm';
  static const String approvalCenterOrder =
      '$baseUrl/offices/orders/approval-center-order';
  static const String rejectCenterOrder =
      '$baseUrl/offices/orders/reject-center-order';
  // --------------------------------------------------

  // --------------- Reports Endpoints -------------------
  static const String getCentersReport =
      '$baseUrl/offices/reports/centers-report';

  static const String getVaccinesQtyReport =
      '$baseUrl/offices/reports/vaccines-qty-report';

  static const String getStatusReport =
      '$baseUrl/offices/reports/status-report';
  static const String getStatusInAllCentersReport =
      '$baseUrl/offices/reports/status-all-centers-report';

  static const String getAllOrdersReport =
      '$baseUrl/offices/reports/orders-all-report';
  static const String getAllVaccinesOfAllCentersOrdersReport =
      '$baseUrl/offices/reports/orders-vaccines-centers-report';
  static const String getAllStatesOfAllCentersOrdersReport =
      '$baseUrl/offices/reports/orders-states-centers-report';
  static const String getAllStatesOfAllVaccinesOrdersReport =
      '$baseUrl/offices/reports/orders-states-vaccines-report';
  static const String getAllCentersOrdersReport =
      '$baseUrl/offices/reports/orders-centers-report';
  static const String getAllVaccinesOrdersReport =
      '$baseUrl/offices/reports/orders-vaccines-report';
  static const String getAllStatesOrdersReport =
      '$baseUrl/offices/reports/orders-states-report';
  static const String getCustomOrdersReport =
      '$baseUrl/offices/reports/orders-custom-report';
  // --------------------------------------------------
}
