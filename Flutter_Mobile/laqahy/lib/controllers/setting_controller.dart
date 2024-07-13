import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SettingController extends GetxController {
  RxBool switchValue = false.obs;
  List items = [
    {
      'icon': Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.lock_outline_rounded,
          color: MyColors.primaryColor,
        ),
      ),
      'label': 'تغيير كلمة السر',
      'pericon': Icon(
        Icons.arrow_back_ios,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
    },
    {
      'icon': Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.fingerprint_outlined,
          color: MyColors.primaryColor,
        ),
      ),
      'label': 'تفعيل بصمة الأصبع',
      'pericon': Icon(
        Icons.arrow_back_ios,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
    },
    {
      'icon': Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.dark_mode_outlined,
          color: MyColors.primaryColor,
        ),
      ),
      'label': 'الوضع المظلم',
      'pericon': mySwitchButton(),
    },
    {
      'icon': Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.redColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.logout_outlined,
          color: MyColors.redColor,
        ),
      ),
      'label': 'تسجيل الخروج',
      'pericon': Icon(
        Icons.arrow_back_ios,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
    },
  ];

  PageController pageController = PageController();
}
