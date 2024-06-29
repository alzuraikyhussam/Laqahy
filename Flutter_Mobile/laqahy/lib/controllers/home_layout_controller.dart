import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
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
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);
}
