import 'package:flutter/material.dart';

class ReportCardItem {
  String imageName;
  String title;
  Widget? onPressed;

  ReportCardItem({
    required this.imageName,
    required this.title,
    required this.onPressed,
  });
}
