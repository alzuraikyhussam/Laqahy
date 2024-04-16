import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

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
      title: 'تسجيــل خــروج',
      image: 'assets/images/logout-image.png',
      text: 'هل انت متأكد من عملية تسجيل الخروج من حسابك؟',
      onConfirmBtnTap: () {
        Get.offAll(LoginScreen());
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
      cancelBtnColor: MyColors.greyColor,
    );
  }
}
