class ApiEndpoints {
  // *********************************************
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String baseUrl = 'https://laqahy.com/api';
  // *********************************************

  // --------------- Auth Endpoints -------------------
  static const String login = '$baseUrl/mobile/auth/login';
  static const String enableFingerprint =
      '$baseUrl/mobile/auth/enable-fingerprint';
  static const String loginWithFingerprint =
      '$baseUrl/mobile/auth/fingerprint-login';
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
  static const String getChildData =
      '$baseUrl/mobile/child-data/get-child-data';
  // --------------------------------------------------

  // --------------- Post Endpoints -------------------
  static const String getPosts = '$baseUrl/ministry/posts';
  // --------------------------------------------------

  // --------------- Awareness Information Endpoints -------------------
  static const String getAwarenessInfo = '$baseUrl/mobile/awareness-info';
  // --------------------------------------------------

  // --------------- Notifications Endpoints -------------------
  static const String getNotifications = '$baseUrl/mobile/notifications';
  // --------------------------------------------------

  // --------------- Technical Support Endpoints -------------------
  static const String sendMsg = '$baseUrl/support';
  // --------------------------------------------------

  // --------------- Reset Password Endpoints -------------------
  static const String resetPasswordVerify =
      '$baseUrl/mobile/reset-password-verification';
  static const String resetPassword = '$baseUrl/mobile/reset-password';
  // --------------------------------------------------
}
