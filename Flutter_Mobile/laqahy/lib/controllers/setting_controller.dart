import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';

RxBool switchValue = false.obs;

class SettingController extends GetxController {
  List items = [
    {
      'icon': Icon(
        Icons.lock_outline_rounded,
        color: MyColors.primaryColor,
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
      'icon': Icon(
        Icons.fingerprint,
        color: MyColors.primaryColor,
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
      'icon': Icon(
        Icons.dark_mode_outlined,
        color: MyColors.primaryColor,
      ),
      'label': 'الوضع المظلم',
      'pericon': CupertinoSwitch(
        value: switchValue.value,
        onChanged: (val) {
          switchValue = val.obs;
          print(switchValue);
        },
      ),
    },
    {
      'icon': Icon(
        Icons.logout_outlined,
        color: MyColors.redColor,
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
