class User {
  int id;
  String username;
  String password;
  String name;
  String phone;
  String address;
  DateTime birthDate;
  String genderType;
  String permissionType;
  String centerName;
  int userGenderId;
  int userPermissionId;
  int centerId;

  User({
    required this.username,
    required this.password,
    required this.id,
    required this.birthDate,
    required this.centerName,
    required this.genderType,
    required this.address,
    required this.name,
    required this.permissionType,
    required this.phone,
    required this.userGenderId,
    required this.userPermissionId,
    required this.centerId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['user_name'] ?? '',
      phone: json['user_phone'] ?? '',
      address: json['user_address'] ?? '',
      birthDate: json['user_birthdate'] != null
          ? DateTime.parse(json['user_birthdate'])
          : DateTime(1970, 1, 1), // default value if null
      username: json['user_account_name'] ?? '',
      password: json['user_account_password'] ?? '',
      genderType: json['genders_type'] ?? '',
      centerName: json['healthy_center_name'] ?? '',
      permissionType: json['permission_type'] ?? '',
      userGenderId: json['gender_id'] ?? 0,
      userPermissionId: json['permission_type_id'] ?? 0,
      centerId: json['healthy_center_id'] ?? 0,
    );
  }
}
