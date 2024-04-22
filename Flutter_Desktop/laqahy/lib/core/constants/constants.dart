import 'package:flutter/material.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/icons/my_flutter_app_icons.dart';

class Constants {
  static List homeLayoutItems = [
    HomeLayoutListItem(
      imageName: 'assets/icons/home-gr.png',
      label: 'الرئيسية',
      imageNameFocused: 'assets/icons/home-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/emp-gr.png',
      label: 'الموظفين',
      imageNameFocused: 'assets/icons/emp-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/status-gr.png',
      label: 'الحالات',
      imageNameFocused: 'assets/icons/status-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/visits-gr.png',
      label: 'الزيارات',
      imageNameFocused: 'assets/icons/visits-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/vaccine-gr.png',
      label: 'اللقاحات',
      imageNameFocused: 'assets/icons/vaccine-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/order-gr.png',
      label: 'الطلبات',
      imageNameFocused: 'assets/icons/order-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/info-gr.png',
      label: 'حول النظام',
      imageNameFocused: 'assets/icons/info-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/support-gr.png',
      label: 'الدعم الفني',
      imageNameFocused: 'assets/icons/support-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/logout.png',
      label: 'تسجيل الخروج',
      imageNameFocused: 'assets/icons/logout.png',
    ),
  ];
}
