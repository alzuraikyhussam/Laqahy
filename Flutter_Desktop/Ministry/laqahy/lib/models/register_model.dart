import 'package:intl/intl.dart';

class Register {
  int? officeId;
  String officeName;
  String officePhone;
  String officeAddress;
  int officeCityId;
  // String? deviceName;
  // String? deviceUserName;
  // String? deviceMacAddress;
  int? userId;
  String userName;
  String userPhone;
  String userAddress;
  DateTime userBirthDate;
  String userAccountName;
  String userPassword;
  int userGenderId;
  int userPermissionId;

  Register({
    this.officeId,
    required this.officeName,
    required this.officePhone,
    required this.officeAddress,
    required this.officeCityId,
    //  this.deviceName,
    //  this.deviceUserName,
    //  this.deviceMacAddress,
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

  // factory Register.fromJson(Map<String, dynamic> json) {
  //   return Register(
  //     officeName: json['office_name'],
  //     officePhone: json['office_phone'],
  //     officeAddress: json['office_address'],
  //     officeCityId: json['cities_id'],
  //     userName: json['user_name'],
  //     userPhone: json['user_phone'],
  //     userAddress: json['user_address'],
  //     userBirthDate: json['user_birthDate'],
  //     userAccountName: json['user_account_name'],
  //     userPassword: json['user_account_password'],
  //     userGenderId: json['gender_id'],
  //     officeId: json['office_id'],
  //     userPermissionId: json['permission_type_id'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'office_name': officeName,
      'office_phone': officePhone,
      'office_address': officeAddress,
      'cities_id': officeCityId,
      'user_name': userName,
      'user_phone': userPhone,
      'user_address': userAddress,
      'user_birthDate': DateFormat('yyyy-MM-dd').format(userBirthDate),
      'user_account_name': userAccountName,
      'user_account_password': userPassword,
      'gender_id': userGenderId,
      'permission_type_id': userPermissionId,
    };
  }
}
