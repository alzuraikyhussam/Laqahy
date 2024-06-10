import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

class ApiException {
  myAddedDataSuccessAlert({
    void Function()? onPressed,
  }) {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        backgroundColor: MyColors.primaryColor,
        imageUrl: 'assets/images/success.json',
        title: 'تمت الإضافة بنجاح',
        description: 'لقد تمت عملية الإضافة بنجاح',
        onPressed: onPressed,
      ),
    );
  }

  myDeleteDataSuccessAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        backgroundColor: MyColors.primaryColor,
        imageUrl: 'assets/images/success.json',
        title: 'تم الحذف بنجاح',
        description: 'لقد تمت عملية الحذف بنجاح',
      ),
    );
  }

  myUpdateDataSuccessAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        backgroundColor: MyColors.primaryColor,
        imageUrl: 'assets/images/success.json',
        title: 'تم التعديل بنجاح',
        description: 'لقد تمت عملية التعديل بنجاح',
      ),
    );
  }

  myUnknownExceptionAlert({var statusCode, var error}) {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'خطأ غير متوقع',
        description:
            'عذرا، لقد حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى \n${statusCode ?? error}',
      ),
    );
  }

  myUserAlreadyExistsAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'المستخدم موجود بالفعل',
        description: 'عذرا، هذا المستخدم الذي أدخلته موجود بالفعل',
      ),
    );
  }

  myUserNotFoundAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/404-error.json',
        backgroundColor: MyColors.redColor,
        title: 'المستخدم غير موجود',
        description: 'المستخدم الذي أدخلته غير موجود',
      ),
    );
  }

  myInvalidPasswordAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'كلمة المرور خاطئة',
        description: 'يرجى التأكد من كتابة كلمة المرور بشكل صحيح',
      ),
    );
  }

  mySocketExceptionAlert() {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/no-network2.json',
        height: 280,
        title: 'لا يتوفر اتصال بالإنترنت',
        description: 'يرجى التحقق من اتصالك بالإنترنت',
      ),
    );
  }

  myFetchDataExceptionAlert(var statusCode) {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/500-error.json',
        title: 'فشل في الوصول',
        description:
            'عذرا، لقد حدث خطأ غير متوقع أثناء تحميل البيانات من الخادم، يرجى المحاولة مرة أخرى \n$statusCode',
      ),
    );
  }

  myAccessDatabaseExceptionAlert(var statusCode) {
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/500-error.json',
        title: 'فشل في الوصول',
        description:
            'عذرا، لقد حدث خطأ ما أثناء عملية الوصول الى قاعدة البيانات\n$statusCode',
      ),
    );
  }

  mySnapshotError(
    var snapshotError, {
    required void Function()? onPressedRefresh,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/images/404-error.json',
          width: 220,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'لقد حدث خطأ ما...!\n$snapshotError',
          style: MyTextStyles.font16RedBold,
          maxLines: 2,
        ),
        SizedBox(
          height: 20,
        ),
        myButton(
          onPressed: onPressedRefresh,
          text: 'تحـديـــث',
          textStyle: MyTextStyles.font14WhiteBold,
        ),
      ],
    );
  }

  myDataNotFound({
    required void Function()? onPressedRefresh,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/no-data.json',
            width: 220,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'لـم يتـــم العثــور على نتـــــائج',
            style: MyTextStyles.font16GreyBold,
          ),
          SizedBox(
            height: 20,
          ),
          myButton(
            onPressed: onPressedRefresh,
            text: 'تحـديـــث',
            textStyle: MyTextStyles.font14WhiteBold,
          ),
        ],
      ),
    );
  }
}
