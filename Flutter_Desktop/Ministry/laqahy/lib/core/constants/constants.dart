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
      label: 'المستخدمين',
      imageNameFocused: 'assets/icons/emp-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/vaccines-gr.png',
      label: 'اللقاحات',
      imageNameFocused: 'assets/icons/vaccines-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/order-gr.png',
      label: 'الطلبات',
      imageNameFocused: 'assets/icons/order-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/posts-gr.png',
      label: 'الإعلانات',
      imageNameFocused: 'assets/icons/posts-wh.png',
    ),
    HomeLayoutListItem(
      imageName: 'assets/icons/reports-gr.png',
      label: 'التقارير',
      imageNameFocused: 'assets/icons/reports-wh.png',
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
