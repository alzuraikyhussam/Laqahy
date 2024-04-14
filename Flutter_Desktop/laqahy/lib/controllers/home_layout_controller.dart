import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:quickalert/models/quickalert_type.dart';

class HomeLayoutController extends GetxController {
  RxString choose = 'الرئيسية'.obs;

  changeChoose(String label, context) {
    if (label == 'تسجيل الخروج') {
      return onTapLogout(context);
    } else {
      choose.value = label;
    }
  }

  onTapLogout(context) {
    return myAlertDialog(
      context: context,
      headerBackgroundColor: MyColors.redColor,
      title: 'تسجيل خروج',
      text: 'هل انت متأكد من عملية تسجيل الخروج من حسابك؟',
      confirmBtnText: 'تسجيـل خــروج',
      cancelBtnText: 'إلغــاء الأمــر',
      image: 'assets/images/logout-image.png',
      confirmBtnColor: MyColors.redColor,
      onConfirmBtnTap: () {
        Get.to(LoginScreen());
        choose.value = 'الرئيسية';
      },
      onCancelBtnTap: () {
        Get.back();
      },
    );
  }

  onTapExitButton(context) {
    return myAlertDialog(
      context: context,
      headerBackgroundColor: MyColors.primaryColor,
      title: 'إغــلاق النـظــام',
      text: 'هل انت متأكد من عملية الخروج من النظام؟',
      confirmBtnText: 'نعــــم',
      cancelBtnText: 'إلغــاء الأمــر',
      image: 'assets/images/exit-image.png',
      confirmBtnColor: MyColors.primaryColor,
      onConfirmBtnTap: () {
        exit(0);
      },
      onCancelBtnTap: () {
        Get.back();
      },
    );
  }
}
