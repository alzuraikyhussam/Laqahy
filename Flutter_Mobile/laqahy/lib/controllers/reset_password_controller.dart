import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  String? phoneNumberValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال  رقم الهاتف';
    }
    return null;
  }

  TextEditingController idNumberController = TextEditingController();
  String? idNumberValidator(Value) {
    if (Value.trim().isEmpty) {
      return 'يجب ادخال الرقم الوطني';
    } else if (!GetUtils.isNumericOnly(Value)) {
      return 'يجب ادخال الرقم الوطني بشكل صحيح';
    }
    return null;
  }

  Future<void> resetPassword() async {
    StaticDataController sdc = Get.put(StaticDataController());

    try {
      isLoading(true);
      final verifyData = Login(
        identityNum: idNumberController.text,
        phoneNum: phoneNumberController.text,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.resetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(verifyData.toJson()),
      );

      if (response.statusCode == 200) {
        isLoading(false);

        var data = json.decode(response.body);

        Login user = Login.fromJson(data['user']);

        Get.to(
          arguments: user.id,
          () => ResetPasswordVerification(),
        );

        return;
      } else if (response.statusCode == 404) {
        isLoading(false);
        ApiExceptionWidgets().myDataIncorrectAlert();
        return;
      } else if (response.statusCode == 401) {
        isLoading(false);
        ApiExceptionWidgets().myInvalidPasswordAlert();
        return;
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();

      return;
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
