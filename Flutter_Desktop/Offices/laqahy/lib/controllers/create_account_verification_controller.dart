import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/create_account/create_admin_account.dart';

class CreateAccountVerificationController extends GetxController {
  GlobalKey<FormState> createAccountVerification = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  var isVerifyLoading = false.obs;

  String? codeValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال كود التحقق';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 5)) {
      return 'يجب ألا يقل عن 5 ارقام وحروف';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'يجب ألا يحتوي على رموز او أحرف عربية';
    }
    return null;
  }

  RxBool isVisible = false.obs;

  changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  Future<void> checkCodeVerification() async {
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

        Get.back();
        Get.to(const CreateAdminAccount());

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
