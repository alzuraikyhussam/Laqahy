import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLayoutListItem {
  String imageName;
  String imageNameFocused;
  String label;

  HomeLayoutListItem({
    required this.imageName,
    required this.imageNameFocused,
    required this.label,
  });
}

class HomeCardItem {
  String? title;
  String? imagePath;
  int? count;

  HomeCardItem({
    required this.title,
    required this.imagePath,
    required this.count,
  });
}

// class VaccinesData {
//   String imageName;
//   String icon;
//   String title;
//   int value;

//   VaccinesData({
//     required this.imageName,
//     required this.icon,
//     required this.title,
//     required this.value,
//   });
// }

// class UserData {
//   String? name;
//   int? phone;
//   int? age;

//   UserData({required this.name, required this.phone, required this.age});
// }

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
