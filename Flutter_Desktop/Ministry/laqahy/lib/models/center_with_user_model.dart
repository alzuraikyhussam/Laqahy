import 'package:intl/intl.dart';

class CenterWithUser {
  int? centerId;
  String centerName;
  String centerPhone;
  String centerAddress;
  int centerDirectorateId;
  int centerCityId;

  int? userId;
  String userName;
  String userPhone;
  String userAddress;
  DateTime userBirthDate;
  String userAccountName;
  String userPassword;
  int userGenderId;
  int userPermissionId;

  CenterWithUser({
    this.centerId,
    required this.centerName,
    required this.centerPhone,
    required this.centerAddress,
    required this.centerDirectorateId,
    required this.centerCityId,
    this.userId,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
    required this.userBirthDate,
    required this.userAccountName,
    required this.userPassword,
    required this.userGenderId,
    required this.userPermissionId,
  });

  factory CenterWithUser.fromJson(Map<String, dynamic> json) {
    return CenterWithUser(
      centerName: json['healthy_center_name'],
      centerPhone: json['healthy_center_phone'],
      centerAddress: json['healthy_center_address'],
      centerCityId: json['cities_id'],
      centerDirectorateId: json['directorate_id'],
      userName: json['user_name'],
      userPhone: json['user_phone'],
      userAddress: json['user_address'],
      userBirthDate: json['user_birthdate'],
      userAccountName: json['user_account_name'],
      userPassword: json['user_account_password'],
      userGenderId: json['gender_id'],
      centerId: json['healthy_center_id'],
      userPermissionId: json['permission_type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthy_center_name': centerName,
      'healthy_center_phone': centerPhone,
      'healthy_center_address': centerAddress,
      'cities_id': centerCityId,
      'directorate_id': centerDirectorateId,
      'user_name': userName,
      'user_phone': userPhone,
      'user_address': userAddress,
      'user_birthdate': DateFormat('yyyy-MM-dd').format(userBirthDate),
      'user_account_name': userAccountName,
      'user_account_password': userPassword,
      'gender_id': userGenderId,
      'permission_type_id': userPermissionId,
      'healthy_center_id': centerId,
    };
  }
}
