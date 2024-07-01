import 'package:intl/intl.dart';

class Register {
  int? userId;
  int? officeId;
  String userName;
  String userPhone;
  String userAddress;
  DateTime userBirthDate;
  String userAccountName;
  String userPassword;
  int userGenderId;
  int userPermissionId;

  Register({
    this.userId,
    this.officeId,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
    required this.userBirthDate,
    required this.userAccountName,
    required this.userPassword,
    required this.userGenderId,
    required this.userPermissionId,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      userId: json['id'] ?? 0,
      userName: json['user_name'] ?? '',
      userPhone: json['user_phone'] ?? '',
      userAddress: json['user_address'] ?? '',
      userBirthDate: json['user_birthDate'] ?? '',
      userAccountName: json['user_account_name'] ?? '',
      userPassword: json['user_account_password'] ?? '',
      userGenderId: json['gender_id'] ?? 0,
      userPermissionId: json['permission_type_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'user_phone': userPhone,
      'user_address': userAddress,
      'user_birthDate': DateFormat('yyyy-MM-dd').format(userBirthDate),
      'user_account_name': userAccountName,
      'user_account_password': userPassword,
      'gender_id': userGenderId,
      'permission_type_id': userPermissionId,
      'office_id': officeId,
    };
  }
}
