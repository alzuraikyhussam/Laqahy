import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  List<TabItem> items = [
    const TabItem(
      icon: Icons.home_outlined,
      title: 'الرئيسية',
    ),
    const TabItem(
      icon: Icons.newspaper_outlined,
      title: 'المنشورات',
    ),
    const TabItem(
      icon: Icons.account_box_outlined,
      title: 'البروفايل',
    ),
  ];

  PageController pageController = PageController();

  var visit = 0.obs;
}
