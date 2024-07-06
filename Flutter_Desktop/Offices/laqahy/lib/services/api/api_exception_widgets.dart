import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

class ApiExceptionWidgets {
  myAddedDataSuccessAlert({
    void Function()? onPressed,
  }) {
    Constants().playSuccessSound();
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
    Constants().playSuccessSound();
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

  myCannotDeleteVaccineStatementAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        imageUrl: 'assets/images/error.json',
        title: 'خطــــأ',
        description:
            'عذرا، لقد تم استخدام كمية من هذا اللقاح ولا يمكنك حذف الكمية حالياً',
      ),
    );
  }

  myCannotUpdateVaccineStatementAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        imageUrl: 'assets/images/error.json',
        title: 'خطــــأ',
        description:
            'عذرا، لقد تم استخدام كمية من هذا اللقاح ولا يمكنك تعديل الكمية حالياً',
      ),
    );
  }

  myUpdateDataSuccessAlert() {
    Constants().playSuccessSound();
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
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'خطأ غير متوقع',
        description:
            'عذرا، لقد حدث خطأ غير متوقع، يجب المحاولة مرة أخرى \n${statusCode ?? error}',
      ),
    );
  }

  myUserAlreadyExistsAlert() {
    Constants().playErrorSound();
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

  myCodeVerificationNotFoundAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/404-error.json',
        backgroundColor: MyColors.redColor,
        title: 'كود التحقق غير صحيح',
        description: 'يرجى التأكد من كتابة كود التحقق بشكل صحيح',
      ),
    );
  }

  myUserNotFoundAlert() {
    Constants().playErrorSound();
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

  myUserNotFoundInThisOfficeAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'خطـــأ',
        description:
            'عذراً، لا يمكنك تسجيل الدخول بهذا المستخدم لأنه غير موجود في هذا المكتب',
      ),
    );
  }

  myInvalidPasswordAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 270,
        imageUrl: 'assets/images/error.json',
        backgroundColor: MyColors.redColor,
        title: 'كلمة المرور خاطئة',
        description: 'يجب التأكد من كتابة كلمة المرور بشكل صحيح',
      ),
    );
  }

  mySocketExceptionAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/no-network2.json',
        height: 280,
        title: 'لا يتوفر اتصال بالإنترنت',
        description: 'يجب التحقق من اتصالك بالإنترنت',
      ),
    );
  }

  myFetchDataExceptionAlert(var statusCode) {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        imageUrl: 'assets/images/500-error.json',
        title: 'فشل في الوصول',
        description:
            'عذرا، لقد حدث خطأ غير متوقع أثناء تحميل البيانات من الخادم، الرجاء المحاولة مرة أخرى \n$statusCode',
      ),
    );
  }

  myAccessDatabaseExceptionAlert(var statusCode) {
    Constants().playErrorSound();
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/404-error.json',
            width: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'لقد حدث خطأ ما...!\n$snapshotError',
            style: MyTextStyles.font16GreyBold,
            textAlign: TextAlign.center,
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
      ),
    );
  }

  myDataNotFound({
    required void Function()? onPressedRefresh,
    String text = 'لـم يتـــم العثــور على نتـــــائج',
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/no-data.json',
            width: 200,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: MyTextStyles.font16GreyBold,
            textAlign: TextAlign.center,
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

  myOrderAlert({
    required String title,
    required String description,
  }) {
    Constants().playSuccessSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        backgroundColor: MyColors.primaryColor,
        title: title,
        description: description,
        imageUrl: 'assets/images/success.json',
      ),
    );
  }

  myOrderWithQuantityAlert(
      {required String title, required String description, var quantity}) {
    Constants().playSuccessSound();
    myShowDialog(
        context: Get.context!,
        widgetName: AlertDialog(
          alignment: AlignmentDirectional.center,
          actionsAlignment: MainAxisAlignment.center,
          content: Container(
            padding: EdgeInsetsDirectional.only(
              top: 20,
            ),
            height: 300,
            width: 350,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: Get.width,
                    child: Lottie.asset(
                      'assets/images/success.json',
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: MyTextStyles.font18BlackBold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyles.font16GreyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: quantity == 0
                                ? LinearGradient(
                                    colors: [
                                      MyColors.redColor,
                                      MyColors.redColor,
                                    ],
                                    begin: AlignmentDirectional.topCenter,
                                    end: AlignmentDirectional.bottomCenter,
                                  )
                                : LinearGradient(
                                    colors: [
                                      MyColors.primaryColor,
                                      MyColors.secondaryColor,
                                    ],
                                    begin: AlignmentDirectional.topCenter,
                                    end: AlignmentDirectional.bottomCenter,
                                  )),
                        child: Text(
                          'الكميـة المتبقية:  ${quantity} جرعـة',
                          style: MyTextStyles.font16WhiteBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            myButton(
              onPressed: () {
                Get.back();
              },
              width: 150,
              backgroundColor: MyColors.primaryColor,
              text: 'مــوافق',
              textStyle: MyTextStyles.font16WhiteBold,
            ),
          ],
        ));
  }

  myVaccineQtyNotEnoughAlert({required var quantity}) {
    Constants().playErrorSound();
    myShowDialog(
        context: Get.context!,
        widgetName: AlertDialog(
          alignment: AlignmentDirectional.center,
          actionsAlignment: MainAxisAlignment.center,
          content: Container(
            padding: EdgeInsetsDirectional.only(
              top: 20,
            ),
            height: 300,
            width: 350,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: Get.width,
                    child: Lottie.asset(
                      'assets/images/error.json',
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الكمية غير كافية',
                        style: MyTextStyles.font18BlackBold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'عذرا، كمية اللقاح غير كافية لتنفيذ طلبك',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyles.font16GreyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [
                                MyColors.redColor,
                                MyColors.redColor,
                              ],
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                            )),
                        child: Text(
                          'الكميـة المتبقية:  ${quantity} جرعـة',
                          style: MyTextStyles.font16WhiteBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            myButton(
              onPressed: () {
                Get.back();
              },
              width: 150,
              backgroundColor: MyColors.redColor,
              text: 'مــوافق',
              textStyle: MyTextStyles.font16WhiteBold,
            ),
          ],
        ));
  }

  myGeneratePdfFailureAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        imageUrl: 'assets/images/error.json',
        title: 'خطــــأ',
        description: 'لقد حدث خطأ ما أثناء عملية انشاء التقرير',
      ),
    );
  }

  mySharePdfFailureAlert() {
    Constants().playErrorSound();
    myShowDialog(
      context: Get.context!,
      widgetName: ApiExceptionAlert(
        height: 280,
        imageUrl: 'assets/images/error.json',
        title: 'خطــــأ',
        description: 'لقد حدث خطأ ما أثناء عملية مشاركة الملف',
      ),
    );
  }
}
