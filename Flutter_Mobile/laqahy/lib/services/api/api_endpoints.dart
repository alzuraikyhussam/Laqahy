class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  // *********************************************

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/mobile/auth/login';
  // --------------------------------------------------

// --------------- Mother Statement Endpoints -------------------
  static const String getMotherDosage = '$baseUrl/mobile/mother-statements/get-mother-dosage';
  // --------------------------------------------------
}
