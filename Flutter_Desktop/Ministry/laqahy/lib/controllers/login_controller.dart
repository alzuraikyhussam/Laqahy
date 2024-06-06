import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/user_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_alert.dart';
import 'package:laqahy/view/layouts/home/home_layout.dart';

class LoginController extends GetxController {
  RxBool isVisible = false.obs;
  var isLoading = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  TextEditingController userNameController = TextEditingController();
  String? userNameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال اسم المستخدم';
    } else if (!GetUtils.isUsername(value)) {
      return 'يرجى ادخال اسم مستخدم صالح';
    }
    return null;
  }

  //////////
  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(value) {
    if (value.isEmpty) {
      return 'يرجى ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب أن تكون على الأقل 8 أحرف';
    }
    return null;
  }

  Future<void> login() async {
    StaticDataController sdc = Get.find<StaticDataController>();
    try {
      isLoading(true);
      final loginData = Login(
        username: userNameController.text,
        password: passwordController.text,
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
        print(data['center']);

        // Handle user and center objects
        User user = User.fromJson(data['user']);
        HealthyCenter center = HealthyCenter.fromJson(data['center']);

        sdc.userLoggedData.assignAll([user]);
        sdc.centerData.assignAll([center]);

        // Save SharedPreferences
        StaticDataController controller = Get.find<StaticDataController>();
        if (await controller.storageService.getCenterId() == 0) {
          await controller.storageService.setCenterId(sdc.centerData.first.id!);
        }
        if (!await controller.storageService.isRegistered()) {
          await controller.storageService.setRegistered(true);
        }

        Get.offAll(const HomeLayout());

        return;
      } else if (response.statusCode == 404) {
        isLoading(false);
        ApiExceptionAlert().myUserNotFoundAlert();
        return;
      } else if (response.statusCode == 401) {
        isLoading(false);
        ApiExceptionAlert().myInvalidPasswordAlert();
        return;
      } else {
        isLoading(false);
        ApiExceptionAlert().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionAlert().mySocketExceptionAlert();
      return;
    } catch (e) {
      isLoading(false);
      print(e);
      ApiExceptionAlert().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
