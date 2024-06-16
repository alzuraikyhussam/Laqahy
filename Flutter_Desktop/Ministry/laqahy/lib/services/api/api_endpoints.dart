class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // --------------- Post Endpoints -------------------
  static const String getPosts = '$baseUrl/posts';
  static const String addPost = '$baseUrl/posts/add-post';
  static const String updatePost = '$baseUrl/posts/update-post';
  static const String deletePost = '$baseUrl/posts/delete-post';
  static const String forceDeletePost = '$baseUrl/posts/force-delete';
  static const String forceDeleteAllPosts = '$baseUrl/posts/force-delete-all';
  static const String restorePost = '$baseUrl/posts/restore';
  static const String restoreAllPost = '$baseUrl/posts/restore-all';
  static const String getTrashedPost = '$baseUrl/posts/trashed';
  // --------------------------------------------------

  // --------------- Gender Endpoints -------------------
  static const String getGenders = '$baseUrl/genders';
  // --------------------------------------------------

  // --------------- Gender Endpoints -------------------
  static const String getOffices = '$baseUrl/offices';
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

  // --------------- Login Endpoints -------------------
  static const String getUsers = '$baseUrl/users';
  static const String addUser = '$baseUrl/users/add-user';
  static const String updateUser = '$baseUrl/users/update-user';
  static const String deleteUser = '$baseUrl/users/delete-user';
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
}
