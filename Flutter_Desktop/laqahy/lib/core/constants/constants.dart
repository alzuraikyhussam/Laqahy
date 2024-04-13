import 'package:flutter/material.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/icons/my_flutter_app_icons2.dart';

class Constants {
  static List homeLayoutItems = [
    HomeLayoutListItem(icon: Icons.access_alarm_sharp, label: 'الرئيسية'),
    HomeLayoutListItem(icon: Icons.person_sharp, label: 'الموظفين'),
    HomeLayoutListItem(icon: Icons.update, label: 'الحالات'),
    HomeLayoutListItem(icon: Icons.people_alt_rounded, label: 'الزيارات'),
    HomeLayoutListItem(icon: Icons.vaccines_rounded, label: 'اللقاحات'),
    HomeLayoutListItem(icon: Icons.post_add_rounded, label: 'المنشورات'),
    HomeLayoutListItem(icon: Icons.info_outline_rounded, label: 'حول النظام'),
    HomeLayoutListItem(icon: Icons.support_agent_rounded, label: 'الدعم الفني'),
    HomeLayoutListItem(icon: Icons.logout_rounded, label: 'تسجيل الخروج'),
  ];
}
