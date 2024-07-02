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


  
  // --------------- Mother Status Data Endpoints -------------------
  static const String addMotherStatusData = '$baseUrl/center/motherData/add-motherData';
  static const String getMothersData = '$baseUrl/center/motherData/get-motherData';
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
