import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/create_account/create_admin_account.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateAccountVerificationController extends GetxController {
  GlobalKey<FormState> createAccountVerification = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  var isVerifyLoading = false.obs;

  String? codeValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال كود التحقق';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 8)) {
      return 'يجب ألا يقل عن 8 ارقام او حروف';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'يجب ألا يحتوي على رموز او أحرف عربية';
    }
    return null;
  }

  RxBool isVisible = false.obs;

  changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  Future<void> checkVerificationCode() async {
    StaticDataController sdc = Get.find<StaticDataController>();
    try {
      isVerifyLoading(true);
      var code = codeController.text;
      var response = await http.get(
        Uri.parse('${ApiEndpoints.registerVerification}/$code'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        Office office = Office.fromJson(data['office']);

        sdc.officeData.assignAll([office]);

        Constants().playSuccessSound();
        myShowDialog(
          context: Get.context!,
          widgetName: ApiExceptionAlert(
            height: 280,
            backgroundColor: MyColors.primaryColor,
            imageUrl: 'assets/images/success.json',
            title: 'تم التحقق بنجاح',
            description:
                'يجب القيام بملئ الحقول التالية لإكمال عملية إنشاء الحساب',
            onPressed: () {
              Get.offAll(const CreateAdminAccount());
              Get.delete<CreateAccountVerificationController>();
            },
          ),
        );

        isVerifyLoading(false);
        return;
      } else if (response.statusCode == 404) {
        isVerifyLoading(false);
        ApiExceptionWidgets().myCodeVerificationNotFoundAlert();
        return;
      } else {
        isVerifyLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isVerifyLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isVerifyLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isVerifyLoading(false);
    }
  }
}
