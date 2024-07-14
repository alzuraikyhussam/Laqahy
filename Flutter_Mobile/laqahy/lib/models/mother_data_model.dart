import 'package:laqahy/models/login_model.dart';

class MotherData {
  Login user;
  DateTime? returnDate;
  int? childrenCount;

  MotherData({
    required this.user,
    this.childrenCount,
    this.returnDate,
  });

  factory MotherData.fromJson(Map<String, dynamic> json) {
    return MotherData(
      user: Login.fromJson(json['user']),
      childrenCount: json['children_count'] ?? 0,
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : DateTime(1970, 1, 1),
    );
  }
}
