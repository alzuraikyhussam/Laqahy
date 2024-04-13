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

  IconData icon;
  String label;

  HomeLayoutListItem({required this.icon, required this.label});
}

class HomeCards {
  String imageName;
  String title;
  int value;

  HomeCards({required this.imageName, required this.title, required this.value});
}
