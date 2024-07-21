import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/child_visit_controller.dart';
import 'package:laqahy/controllers/home_controller.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/controllers/technical_support_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
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
        if (Get.isRegistered<HomeController>()) {
          Get.delete<HomeController>();
        }
        if (Get.isRegistered<UserController>()) {
          Get.delete<UserController>();
        }
        if (Get.isRegistered<OrdersController>()) {
          Get.delete<OrdersController>();
        }
        if (Get.isRegistered<ReportController>()) {
          Get.delete<ReportController>();
        }
        if (Get.isRegistered<MotherVisitController>()) {
          Get.delete<MotherVisitController>();
        }
        if (Get.isRegistered<MotherStatusDataController>()) {
          Get.delete<MotherStatusDataController>();
        }
        if (Get.isRegistered<ChildStatusDataController>()) {
          Get.delete<ChildStatusDataController>();
        }
        if (Get.isRegistered<ChildVisitController>()) {
          Get.delete<ChildVisitController>();
        }
        if (Get.isRegistered<VaccineController>()) {
          Get.delete<VaccineController>();
        }
        if (Get.isRegistered<TechnicalSupportController>()) {
          Get.delete<TechnicalSupportController>();
        }
        if (Get.isRegistered<TechnicalSupportController>()) {
          Get.delete<TechnicalSupportController>();
        }
      }

      choose.value = label;
    }
  }

  onTapLogout(context) {
    // Constants().playErrorSound();

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
    // Constants().playErrorSound();

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
