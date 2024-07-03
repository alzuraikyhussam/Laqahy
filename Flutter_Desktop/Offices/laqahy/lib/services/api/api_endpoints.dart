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

  // --------------- User Endpoints -------------------
  static const String getUsers = '$baseUrl/offices/users';
  static const String getAdmin = '$baseUrl/offices/users/get-admin';
  static const String addUser = '$baseUrl/offices/users/add-user';
  static const String updateUser = '$baseUrl/offices/users/update-user';
  static const String deleteUser = '$baseUrl/offices/users/delete-user';
  // --------------------------------------------------
}
