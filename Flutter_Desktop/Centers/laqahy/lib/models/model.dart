import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLayoutListItem {
  // static List listMain = [
  //   {"icon": Icons.dataset_outlined, "title": "الرئيسية"},
  //   {"icon": Icons.groups_2_outlined, "title": "الموظفين"},
  //   {"icon": Icons.medical_services_outlined, "title": "الحالات"},
  //   {"icon": Icons.people_alt_outlined, "title": "الزيارات"},
  //   {"icon": Icons.vaccines_outlined, "title": "اللقاحات"},
  //   {"icon": Icons.paste_outlined, "title": "المنشورات"},
  //   {"icon": Icons.info_outline, "title": "حول النظام"},
  //   {"icon": Icons.co_present_outlined, "title": "الدعم الفني"},
  //   {"icon": Icons.logout_rounded, "title": "تسجيل الخروج"},
  // ];

  String imageName;
  String imageNameFocused;
  String label;

  HomeLayoutListItem({
    required this.imageName,
    required this.imageNameFocused,
    required this.label,
  });
}

class HomeCards {
  String imageName;
  String title;
  int value;

  HomeCards({
    required this.imageName,
    required this.title,
    required this.value,
  });
}

class UserData {
  int? id;
  String? name;
  String? gender;
  dynamic birthDate;
  String? permission;
  String? phoneNumber;
  String? username;
  String? password;
  String? address;
  String? healthCenter;

  UserData({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.gender,
    required this.phoneNumber,
    required this.permission,
    required this.address,
    this.healthCenter,
  });
}

class MotherVisitData {
  int? id;
  String? dosageType;
  String? fullUserName;
  String? healthCenter;
  dynamic dosageDate;
  dynamic returnDate;

  MotherVisitData({
    this.id,
    required this.dosageType,
    required this.fullUserName,
    required this.healthCenter,
    required this.dosageDate,
    required this.returnDate,
  });
}
