class Login {
  String userAccountName;
  String userAccountPassword;
  int? userId;
  String? userName;
  String? userPhone;
  String? userAddress;
  DateTime? userBirthDate;
  int? userGenderId;
  int? userPermissionId;
  int? centerId;

  Login({
    required this.userAccountName,
    required this.userAccountPassword,
    this.userAddress,
    this.userBirthDate,
    this.userGenderId,
    this.userId,
    this.userName,
    this.userPermissionId,
    this.userPhone,
    this.centerId,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      userId: json['id'],
      userName: json['user_name'] ?? '',
      userPhone: json['user_phone'] ?? '',
      userAddress: json['user_address'] ?? '',
      userBirthDate: json['user_birthDate'] != null
          ? DateTime.parse(json['user_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      userAccountName: json['user_account_name'] ?? '',
      userAccountPassword: json['user_account_password'] ?? '',
      userGenderId: json['gender_id'] ?? 0,
      centerId: json['healthy_center_id'] ?? 0,
      userPermissionId: json['permission_type_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_account_name': userAccountName,
      'user_account_password': userAccountPassword,
    };
  }
}
