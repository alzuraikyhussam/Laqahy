import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class HomeCard {
  String imageName;
  String title;
  int value;

  HomeCard({
    required this.imageName,
    required this.title,
    required this.value,
  });
}

class VaccinesData {
  String imageName;
  String icon;
  String title;
  int value;

  VaccinesData({
    required this.imageName,
    required this.icon,
    required this.title,
    required this.value,
  });
}

class UserData {
  String? name;
  int? phone;
  int? age;

  UserData({required this.name, required this.phone, required this.age});
}

class ReportsData {
  String imageName;
  String title;
  Widget? onPressed;

  ReportsData({
    required this.imageName,
    required this.title,
    required this.onPressed,
  });
}
