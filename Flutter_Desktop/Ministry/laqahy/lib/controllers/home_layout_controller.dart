import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/post_controller.dart';
import 'package:laqahy/controllers/home_controller.dart';
import 'package:laqahy/controllers/orders_layout_controller.dart';
import 'package:laqahy/controllers/reports_controller.dart';
import 'package:laqahy/controllers/technical_support_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/controllers/vaccines_card_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeLayoutController extends GetxController {
  RxString choose = 'الرئيسية'.obs;

  changeChoose(String label, {context}) {
    if (label == 'تسجيل الخروج') {
      return onTapLogout(context);
    } else {
      if (choose.value != label) {
        // Delete controller
        if (Get.isRegistered<HomeController>()) Get.delete<HomeController>();
        if (Get.isRegistered<UserController>()) Get.delete<UserController>();
        if (Get.isRegistered<VaccinesCardController>())
          Get.delete<VaccinesCardController>();
        if (Get.isRegistered<OrdersLayoutController>())
          Get.delete<OrdersLayoutController>();
        if (Get.isRegistered<PostController>()) Get.delete<PostController>();
        if (Get.isRegistered<ReportsController>())
          Get.delete<ReportsController>();
        if (Get.isRegistered<TechnicalSupportController>())
          Get.delete<TechnicalSupportController>();
      }

      choose.value = label;
    }
  }

  onTapLogout(context) {
    return myAlertDialog(
      context: context,
      title: 'تسجيــل خــروج',
      image: 'assets/images/logout-image.png',
      text: 'هل انت متأكد من عملية تسجيل الخروج من حسابك؟',
      onConfirmBtnTap: () {
        Get.offAll(() => LoginScreen());
      },
      onCancelBtnTap: () {
        Get.back();
      },
      confirmBtnText: 'تسجيــل خــروج',
      cancelBtnText: 'إلغــاء الأمــر',
      cancelBtnColor: MyColors.greyColor,
      confirmBtnColor: MyColors.redColor,
    );
  }

  onTapMinimize() {
    appWindow.minimize();
  }

  onTapExitButton(context) {
    return myAlertDialog(
      context: context,
      title: 'إغــلاق النــظـام',
      image: 'assets/images/exit-image.png',
      text: 'هل انت متأكد من عملية الخروج من النظام؟',
      onConfirmBtnTap: () {
        exit(0);
      },
      onCancelBtnTap: () {
        Get.back();
      },
      confirmBtnText: 'إغــلاق النــظـام',
      cancelBtnText: 'إلغــاء الأمــر',
      confirmBtnColor: MyColors.redColor,
      cancelBtnColor: MyColors.greyColor,
    );
  }
}
