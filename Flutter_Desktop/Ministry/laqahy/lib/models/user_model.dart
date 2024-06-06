import 'package:intl/intl.dart';

class User {
  int? id;
  String name;
  String phone;
  String address;
  DateTime birthDate;
  String username;
  String password;
  int genderId;
  int permissionId;
  int centerId;

  User({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.birthDate,
    required this.username,
    required this.password,
    required this.genderId,
    required this.centerId,
    required this.permissionId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user_name'] ?? '',
      phone: json['user_phone'] ?? '',
      address: json['user_address'] ?? '',
      birthDate: json['user_birthdate'] != null
          ? DateTime.parse(json['user_birthdate'])
          : DateTime(1970, 1, 1), // default value if null
      username: json['user_account_name'] ?? '',
      password: json['user_account_password'] ?? '',
      genderId: json['gender_id'] ?? 0,
      centerId: json['healthy_center_id'] ?? 0,
      permissionId: json['permission_type_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': name,
      'user_phone': phone,
      'user_address': address,
      'user_birthdate': DateFormat('yyyy-MM-dd').format(birthDate),
      'user_account_name': username,
      'user_account_password': password,
      'gender_id': genderId,
      'permission_type_id': permissionId,
      'healthy_center_id': centerId,
    };
  }
}
