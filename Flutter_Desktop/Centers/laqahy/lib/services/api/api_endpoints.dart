class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // *********************************************

  // --------------- Total Count Endpoints -------------------
  static const String getTotalCount =
      '$baseUrl/centers/general/home-total-count';
  // --------------------------------------------------

  // --------------- Gender Endpoints -------------------
  static const String getGenders = '$baseUrl/genders';
  // --------------------------------------------------

  // --------------- Healthy Center Endpoints -------------------
  static const String getCenters = '$baseUrl/centers/get-centers';
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
      '$baseUrl/centers/auth/register/verify';
  // --------------------------------------------------

  // --------------- Register Endpoints -------------------
  static const String register = '$baseUrl/centers/auth/register';
  // --------------------------------------------------

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/centers/auth/login';
  // --------------------------------------------------

  // --------------- Vaccines Endpoints -------------------
  static const String getVaccines = '$baseUrl/vaccines';
  static const String getVaccinesType = '$baseUrl/centers/get-vaccines-data';
  static const String getDosageTypeWithVaccine = '$baseUrl/centers/get-dosage-type-data';
  // --------------------------------------------------
  
  // --------------- Visit Type Endpoints -------------------
  static const String getVisitType = '$baseUrl/centers/get-visit-type';
  // --------------------------------------------------

  // --------------- Healthy Centers Stock Vaccines Endpoints -------------------
  static const String getVaccinesQuantity =
      '$baseUrl/centers/vaccines-quantity';
  // --------------------------------------------------

  // --------------- User Endpoints -------------------
  static const String getUsers = '$baseUrl/centers/users';
  static const String getAdmin = '$baseUrl/centers/users/get-admin';
  static const String addUser = '$baseUrl/centers/users/add-user';
  static const String updateUser = '$baseUrl/centers/users/update-user';
  static const String deleteUser = '$baseUrl/centers/users/delete-user';
  // --------------------------------------------------

// --------------- Order Endpoints -------------------
  static const String addOrder = '$baseUrl/centers/orders/add-order';
  static const String getOutgoingOrders = '$baseUrl/centers/orders/outgoing';
  static const String getInDeliveryOrders =
      '$baseUrl/centers/orders/in-delivery';
  static const String getDeliveredOrders = '$baseUrl/centers/orders/delivered';
  static const String getRejectedOrders = '$baseUrl/centers/orders/rejected';
  static const String receivingOrderConfirm =
      '$baseUrl/centers/orders/receiving-confirm';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------

  // --------------- Mother Status Data Endpoints -------------------
  static const String addMotherStatusData =
      '$baseUrl/centers/mother-data/add-mother';
  static const String getMothersData =
      '$baseUrl/centers/mother-data/get-mother-data';
  // --------------------------------------------------

  // --------------- Mother Statement Data Endpoints -------------------
  static const String addMotherStatement =
      '$baseUrl/centers/mother-statement/add-mother-statement';
  static const String getMotherStatement =
      '$baseUrl/centers/mother-statement/get-mother-statement';
  static const String deleteMotherStatement =
      '$baseUrl/centers/mother-statement/delete-mother-statement';

  // --------------------------------------------------

  // --------------- Child Status Data Endpoints -------------------
  static const String addChildStatusData =
      '$baseUrl/centers/child-data/add-child';
  static const String getChildData =
      '$baseUrl/centers/child-data/get-child';

  // --------------------------------------------------

  // --------------- Dosage Level Data Endpoints -------------------
  static const String getDosageLevel = '$baseUrl/centers/dosage-level';
  // --------------------------------------------------

  // --------------- Child Status Data Endpoints -------------------
  static const String getDosageType = '$baseUrl/centers/dosage-type';
  // --------------------------------------------------
}
