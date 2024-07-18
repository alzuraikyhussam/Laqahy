import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/mother_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/layouts/home_layout.dart';

class LoginController extends GetxController {
  RxBool isVisible = false.obs;
  var isLoading = false.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
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
  /////////

  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب ألا تقل عن 8 أحرف';
    }
    return null;
  }

  Future<void> login() async {
    StaticDataController sdc = Get.put(StaticDataController());
    try {
      isLoading(true);

      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        print(fcmToken);
        try {
          final loginData = Login(
            identityNum: idNumberController.text,
            passWord: passwordController.text,
            token: fcmToken,
          );
          var response = await http.post(
            Uri.parse(ApiEndpoints.login),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(loginData.toJson()),
          );

          if (response.statusCode == 200) {
            isLoading(false);

            var data = json.decode(response.body);

            MotherData user = MotherData.fromJson(data);

            sdc.userLoggedData.assignAll([user]);

            Get.offAll(
              () => const HomeLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 3000),
              curve: Curves.fastLinearToSlowEaseIn,
            );
            Get.delete<LoginController>();
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
      } else {
        ApiExceptionWidgets().mySocketExceptionAlert();
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
