class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // *********************************************

  // --------------- Total Count Endpoints -------------------
  static const String getTotalCount =
      '$baseUrl/ministry/general/home-total-count';
  // --------------------------------------------------

  // --------------- Post Endpoints -------------------
  static const String getPosts = '$baseUrl/ministry/posts';
  static const String addPost = '$baseUrl/ministry/posts/add-post';
  static const String updatePost = '$baseUrl/ministry/posts/update-post';
  static const String deletePost = '$baseUrl/ministry/posts/delete-post';
  static const String forceDeletePost = '$baseUrl/ministry/posts/force-delete';
  static const String forceDeleteAllPosts =
      '$baseUrl/ministry/posts/force-delete-all';
  static const String restorePost = '$baseUrl/ministry/posts/restore';
  static const String restoreAllPost = '$baseUrl/ministry/posts/restore-all';
  static const String getTrashedPost = '$baseUrl/ministry/posts/trashed';
  // --------------------------------------------------

  // --------------- Gender Endpoints -------------------
  static const String getGenders = '$baseUrl/genders';
  // --------------------------------------------------

  // --------------- Office Endpoints -------------------
  static const String updateOffice = '$baseUrl/ministry/offices/update-office';
  static const String getOfficesCentersCount =
      '$baseUrl/ministry/offices/centers-count';
  static const String getRegisteredOffices =
      '$baseUrl/ministry/offices/registered';
  static const String getUnRegisteredOffices =
      '$baseUrl/ministry/offices/unregistered';
  // --------------------------------------------------

  // --------------- Healthy Center Endpoints -------------------
  static const String getCenters = '$baseUrl/ministry/centers';
  static const String getCentersByOffice = '$baseUrl/ministry/centers';
  // --------------------------------------------------

  // --------------- City Endpoints -------------------
  static const String getCities = '$baseUrl/cities';
  // --------------------------------------------------

  // --------------- Order State Endpoints -------------------
  static const String getOrderStates = '$baseUrl/order-states';
  // --------------------------------------------------

  // --------------- Directorates Endpoints -------------------
  static const String getDirectorates = '$baseUrl/directorates';
  // --------------------------------------------------

  // --------------- Permission Endpoints -------------------
  static const String getPermissions = '$baseUrl/permissions';
  // --------------------------------------------------

  // --------------- Create Account Endpoints -------------------
  static const String register = '$baseUrl/ministry/auth/register';
  // --------------------------------------------------

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/ministry/auth/login';
  // --------------------------------------------------

  // --------------- Login Endpoints -------------------
  static const String getUsers = '$baseUrl/ministry/users';
  static const String getAdmin = '$baseUrl/ministry/users/get-admin';
  static const String addUser = '$baseUrl/ministry/users/add-user';
  static const String updateUser = '$baseUrl/ministry/users/update-user';
  static const String deleteUser = '$baseUrl/ministry/users/delete-user';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------

  // // --------------- Healthy Center Account Endpoints -------------------
  // static const String addCenterAccount = '$baseUrl/centers/add-center-account';
  // // --------------------------------------------------

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
  static const String getVaccineStockDateRange =
      '$baseUrl/ministry/vaccines/date-range';
  // --------------------------------------------------

  // --------------- Donor Endpoints -------------------
  static const String getDonors = '$baseUrl/donors';
  static const String addDonor = '$baseUrl/donors/add-donor';
  // --------------------------------------------------

  // --------------- Order Endpoints -------------------
  static const String getIncomingOrders = '$baseUrl/ministry/orders/incoming';
  static const String getInDeliveryOrders =
      '$baseUrl/ministry/orders/in-delivery';
  static const String getDeliveredOrders = '$baseUrl/ministry/orders/delivered';
  static const String getCancelledOrders = '$baseUrl/ministry/orders/cancelled';
  static const String transferOrderToInDelivery =
      '$baseUrl/ministry/orders/to-in-delivery';
  static const String transferOrderToCancelled =
      '$baseUrl/ministry/orders/to-cancelled';
  static const String undoCancelled = '$baseUrl/ministry/orders/undo-cancelled';
  static const String getOrdersDateRange =
      '$baseUrl/ministry/orders/date-range';
  // --------------------------------------------------

  // --------------- Mother Data Endpoints -------------------
  static const String getMotherDateRange =
      '$baseUrl/ministry/mothers/date-range';
  // --------------------------------------------------

  // --------------- Reports Endpoints -------------------
  static const String getCentersReport =
      '$baseUrl/ministry/reports/centers-report';

  static const String getOfficesReport =
      '$baseUrl/ministry/reports/offices-report';

  static const String getVaccinesQtyReport =
      '$baseUrl/ministry/reports/vaccines-qty-report';

  static const String getStatusReport =
      '$baseUrl/ministry/reports/vaccines-qty-report';
  static const String getStatusInAllOfficesReport =
      '$baseUrl/ministry/reports/status-all-offices-report';
  static const String getStatusInAllCentersReport =
      '$baseUrl/ministry/reports/status-all-centers-report';

  static const String getAllVaccinesStockReport =
      '$baseUrl/ministry/reports/stock/vaccines-all-report';
  static const String getVaccinesStockCustomReport =
      '$baseUrl/ministry/reports/stock/vaccines-custom-report';
  static const String getAllVaccinesStockOfSpecificDonorReport =
      '$baseUrl/ministry/reports/stock/vaccines-specific-donor-report';
  static const String getSpecificVaccineStockOfAllDonorsReport =
      '$baseUrl/ministry/reports/stock/vaccine-all-donors-report';

  static const String getAllOrdersReport =
      '$baseUrl/ministry/reports/orders-all-report';
  static const String getAllVaccinesOfAllOfficesOrdersReport =
      '$baseUrl/ministry/reports/orders-vaccines-offices-report';
  static const String getAllStatesOfAllOfficesOrdersReport =
      '$baseUrl/ministry/reports/orders-states-offices-report';
  static const String getAllStatesOfAllVaccinesOrdersReport =
      '$baseUrl/ministry/reports/orders-states-vaccines-report';
  static const String getAllOfficesOrdersReport =
      '$baseUrl/ministry/reports/orders-offices-report';
  static const String getAllVaccinesOrdersReport =
      '$baseUrl/ministry/reports/orders-vaccines-report';
  static const String getAllStatesOrdersReport =
      '$baseUrl/ministry/reports/orders-states-report';
  static const String getCustomOrdersReport =
      '$baseUrl/ministry/reports/orders-custom-report';
  // --------------------------------------------------
}
