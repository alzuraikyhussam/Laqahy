import 'package:intl/intl.dart';

class User {
  int? id;
  String username;
  String password;
  String name;
  String phone;
  String address;
  DateTime birthDate;
  String? genderType;
  String? permissionType;
  String? centerName;
  int userGenderId;
  int userPermissionId;
  int centerId;

  User({
    required this.username,
    required this.password,
    this.id,
    required this.birthDate,
    this.centerName,
    this.genderType,
    required this.address,
    required this.name,
    this.permissionType,
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
      birthDate: json['user_birthDate'] != null
          ? DateTime.parse(json['user_birthDate'])
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

  Map<String, dynamic> toJson() {
    return {
      'user_name': name,
      'user_phone': phone,
      'user_address': address,
      'user_birthDate': DateFormat('yyyy-MM-dd').format(birthDate),
      'user_account_name': username,
      'user_account_password': password,
      'gender_id': userGenderId,
      'healthy_center_id': centerId,
      'permission_type_id': userPermissionId,
    };
  }
}
