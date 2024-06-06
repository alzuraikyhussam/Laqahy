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
}
