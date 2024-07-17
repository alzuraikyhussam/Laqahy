class ApiEndpoints {
  // *********************************************
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  // *********************************************

  // --------------- Login Endpoints -------------------
  static const String login = '$baseUrl/mobile/auth/login';
  // --------------------------------------------------

  // --------------- Mother Statement Endpoints -------------------
  static const String getMotherDosage =
      '$baseUrl/mobile/mother-statements/get-mother-dosage';
  // --------------------------------------------------

  // --------------- Child Statement Endpoints -------------------
  static const String getChildVaccines =
      '$baseUrl/mobile/child-statements/get-child-vaccines';
  // --------------------------------------------------

  // --------------- Child Data Endpoints -------------------
  static const String getChildVData =
      '$baseUrl/mobile/child-data/get-child-data';
  // --------------------------------------------------

  // --------------- Post Endpoints -------------------
  static const String getPosts = '$baseUrl/ministry/posts';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------
}
