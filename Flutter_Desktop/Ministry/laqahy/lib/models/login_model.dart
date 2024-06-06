class Login {
  String username;
  String password;

  Login({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_account_name': username,
      'user_account_password': password,
    };
  }
}
