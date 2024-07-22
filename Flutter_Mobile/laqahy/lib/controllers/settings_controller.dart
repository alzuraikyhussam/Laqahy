import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/settings_model.dart';
import 'package:laqahy/view/screens/login/login.dart';
import 'package:laqahy/view/screens/reset_password.dart';
import 'package:laqahy/view/widgets/basic_widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SettingsController extends GetxController {
  RxBool isDark = false.obs;

  List<SettingsListItem> settingsListViewItems = [
    SettingsListItem(
      prefix: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.password_rounded,
          color: MyColors.primaryColor,
        ),
      ),
      label: 'تغيير كلمة المرور',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () {
        StaticDataController sdc = Get.put(StaticDataController());
        Get.to(
          () => ResetPassword(motherId: sdc.userLoggedData.first.user.id!),
        );
      },
    ),
    SettingsListItem(
      prefix: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.fingerprint_rounded,
          color: MyColors.primaryColor,
        ),
      ),
      label: 'تفعيل بصمة الأصبع',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () {
        myShowDialog(
          context: Get.context!,
          widgetName: ApiExceptionAlert(
            title: 'الميزة غير متوفرة حالياً',
            description:
                'عذراً، هذه الميزة غير متوفرة حالياً، سيتم تفعيلها قريباً في التحديثات القادمة',
            backgroundColor: MyColors.primaryColor,
            height: 300,
            imageUrl: 'assets/images/warning.json',
          ),
        );
      },
    ),
    SettingsListItem(
      prefix: Container(
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
      label: 'الوضع المظلم',
      suffix: mySwitchButton(),
      onTap: () {},
    ),
    SettingsListItem(
      prefix: Container(
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
      label: 'تسجيل خروج',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () {
        Get.offAll(() => const LoginScreen());
      },
    ),
  ];

  PageController pageController = PageController();
}
