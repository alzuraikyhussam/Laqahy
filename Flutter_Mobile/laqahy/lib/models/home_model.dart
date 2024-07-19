import 'package:flutter/material.dart';

class HomeGridViewItem {
  IconData icon;
  String title;
  void Function()? onTap;

  HomeGridViewItem({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
