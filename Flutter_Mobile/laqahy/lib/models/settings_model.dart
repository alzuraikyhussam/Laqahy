import 'package:flutter/material.dart';

class SettingsListItem {
  Widget prefix;
  String label;
  Widget suffix;
  void Function()? onTap;

  SettingsListItem({
    required this.prefix,
    required this.label,
    required this.suffix,
    this.onTap,
  });
}
