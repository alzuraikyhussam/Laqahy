import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/reset_password.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  GlobalKey<FormState> resetPasswordVerificationFormKey =
      GlobalKey<FormState>();

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

  Future<void> resetPasswordVerification() async {
    try {
      isLoading(true);
      final verifyData = Login(
        identityNum: idNumberController.text,
        phoneNum: phoneNumberController.text,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.resetPasswordVerify),
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
          () => ResetPassword(
            motherId: user.id!,
          ),
        );

        return;
      } else if (response.statusCode == 404) {
        isLoading(false);
        ApiExceptionWidgets().myDataIncorrectAlert();
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

  //////////////////////////

  RxBool isVisible = false.obs;
  RxBool isVisible2 = false.obs;

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  changePasswordVisibility2() {
    isVisible2.value = !isVisible2.value;
  }

  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب ألا تقل عن 8 أحرف';
    }
    return null;
  }

  TextEditingController passwordController2 = TextEditingController();
  String? passwordValidator2(value) {
    if (value.isEmpty) {
      return 'يجب ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب ألا تقل عن 8 أحرف';
    } else if (value != passwordController.text) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  Future<void> resetPassword({
    required int motherId,
  }) async {
    try {
      isLoading(true);
      final resetPass = Login(id: motherId, passWord: passwordController.text);
      var response = await http.patch(
        Uri.parse(ApiEndpoints.resetPassword),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(resetPass.toJson()),
      );

      if (response.statusCode == 200) {
        Get.offAll(
          () => const LoginScreen(),
        );

        isLoading(false);

        Get.delete<ResetPasswordController>();

        return;
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        print(response.body);
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
