import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

class ApiExceptionWidgets {
  myUnknownExceptionAlert({var statusCode, var error}) {
    Get.snackbar(
      'خطأ غير متوقع',
      'عذرا، لقد حدث خطأ غير متوقع، يجب المحاولة مرة أخرى \n${statusCode ?? error}',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  myUserNotFoundAlert() {
    Get.snackbar(
      'المستخدم غير موجود',
      'المستخدم الذي أدخلته غير موجود',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/404-error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  myInvalidPasswordAlert() {
    Get.snackbar(
      'كلمة المرور خاطئة',
      'يجب التأكد من كتابة كلمة المرور بشكل صحيح',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  mySocketExceptionAlert() {
    Get.snackbar(
      'لا يتوفر اتصال بالإنترنت',
      'يجب التحقق من اتصالك بالإنترنت',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/no-network2.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  myFetchDataExceptionAlert(var statusCode) {
    Get.snackbar(
      'فشل في الوصول',
      'عذرا، لقد حدث خطأ غير متوقع أثناء تحميل البيانات من الخادم، الرجاء المحاولة مرة أخرى \n$statusCode',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/500-error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  myAccessDatabaseExceptionAlert(var statusCode) {
    Get.snackbar(
      'فشل في الوصول',
      'عذرا، لقد حدث خطأ ما أثناء عملية الوصول الى قاعدة البيانات\n$statusCode',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/500-error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  mySnapshotError(
    var snapshotError, {
    required void Function()? onPressedRefresh,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/404-error.json',
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'لقد حدث خطأ ما...!\n$snapshotError',
            style: MyTextStyles.font14GreyBold,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          myTextButton(
            text: 'تحـديـــث',
            onPressed: onPressedRefresh,
          ),
        ],
      ),
    );
  }

  myDataNotFound({
    required void Function()? onPressedRefresh,
    String text = 'لم يتـم العثور على نتائج',
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/no-data.json',
            width: 150,
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: MyTextStyles.font16GreyBold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          myTextButton(
            text: 'تحـديـــث',
            onPressed: onPressedRefresh,
          ),
        ],
      ),
    );
  }
}
