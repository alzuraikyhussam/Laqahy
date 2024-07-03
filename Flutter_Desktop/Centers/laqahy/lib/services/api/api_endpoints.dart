class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // *********************************************

  // --------------- Total Count Endpoints -------------------
  static const String getTotalCount = '$baseUrl/general/home-total-count';
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

  // --------------- Create Account Endpoints -------------------
  static const String register = '$baseUrl/auth/register';
  // --------------------------------------------------

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/auth/login';
  // --------------------------------------------------

  // --------------- User Endpoints -------------------
  static const String getUsers = '$baseUrl/ministry/users';
  static const String getAdmin = '$baseUrl/ministry/users/get-admin';
  static const String addUser = '$baseUrl/ministry/users/add-user';
  static const String updateUser = '$baseUrl/ministry/users/update-user';
  static const String deleteUser = '$baseUrl/ministry/users/delete-user';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------



  
  // --------------- Mother Status Data Endpoints -------------------
  static const String addMotherStatusData = '$baseUrl/center/motherData/add-motherData';
  static const String getMothersData = '$baseUrl/center/motherData/get-motherData';

  // --------------- Ministry Stock Vaccines Endpoints -------------------
  static const String getVaccines = '$baseUrl/ministry/vaccines';
  // --------------------------------------------------

  // --------------- Ministry Statement Stock Vaccines Endpoints -------------------
  static const String addVaccineQuantity =
      '$baseUrl/ministry/vaccines/add-quantity';
  static const String getVaccineStatement =
      '$baseUrl/ministry/vaccines/statement';
  static const String updateVaccineStatement =
      '$baseUrl/ministry/vaccines/update-statement';
  static const String deleteVaccineStatement =
      '$baseUrl/ministry/vaccines/delete-statement';
  // --------------------------------------------------

  // --------------- Donor Endpoints -------------------
  static const String getDonors = '$baseUrl/donors';
  static const String addDonor = '$baseUrl/donors/add-donor';
  // --------------------------------------------------

  // --------------- Order Endpoints -------------------
  static const String getIncomingOrders = '$baseUrl/orders/incoming';
  static const String getInDeliveryOrders = '$baseUrl/orders/in-delivery';
  static const String getDeliveredOrders = '$baseUrl/orders/delivered';
  static const String getCancelledOrders = '$baseUrl/orders/cancelled';
  static const String transferOrderToInDelivery =
      '$baseUrl/orders/to-in-delivery';
  static const String transferOrderToCancelled = '$baseUrl/orders/to-cancelled';
  static const String undoCancelled = '$baseUrl/orders/undo-cancelled';
  // --------------------------------------------------

  // --------------- Generate Centers Report Endpoints -------------------
  static const String getCentersReport = '$baseUrl/reports/centers-report';
  // --------------------------------------------------

  // --------------- Mother Status Data Endpoints -------------------
  static const String addMotherStatusData =
      '$baseUrl/motherData/add-motherData';
  static const String getMothersData = '$baseUrl/motherData/get-motherData';

  // --------------------------------------------------

  // --------------- Child Status Data Endpoints -------------------
  static const String addChildStatusData = '$baseUrl/center/childData/add-childData';
  // --------------------------------------------------
  
  // --------------- Dosage Level Endpoints -------------------
  static const String getDosageLevel = '$baseUrl/center/Dosage-Level';
  // --------------------------------------------------
  
  // --------------- Dosage Type Endpoints -------------------
  static const String getDosageType = '$baseUrl/center/Dosage-type';
  // --------------------------------------------------
}
