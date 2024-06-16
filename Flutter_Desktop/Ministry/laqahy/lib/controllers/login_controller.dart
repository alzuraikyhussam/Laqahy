import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/user_models.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/layouts/home/home_layout.dart';
import 'package:laqahy/view/screens/login.dart';

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
      return 'يجب ادخال اسم المستخدم';
    } else if (!GetUtils.isUsername(value)) {
      return 'يجب ادخال اسم مستخدم صالح';
    }
    return null;
  }

  //////////
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
    StaticDataController sdc = Get.find<StaticDataController>();
    try {
      isLoading(true);
      final loginData = Login(
        userAccountName: userNameController.text,
        userAccountPassword: passwordController.text,
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

        // Handle user and center objects
        Login user = Login.fromJson(data['user']);
        HealthyCenter center = HealthyCenter.fromJson(data['center']);

        sdc.userLoggedData.assignAll([user]);
        sdc.centerData.assignAll([center]);

        try {
          // Save SharedPreferences
          if (!await sdc.storageService.isRegistered()) {
            await sdc.storageService.setCenterId(sdc.centerData.first.id!);
            await sdc.storageService
                .setAdminId(sdc.userLoggedData.first.userId!);
            await sdc.storageService.setRegistered(true);
          }
        } catch (_) {}
        Get.offAll(const HomeLayout());
        return;
      } else if (response.statusCode == 404) {
        isLoading(false);
        ApiException().myUserNotFoundAlert();
        return;
      } else if (response.statusCode == 401) {
        isLoading(false);
        ApiException().myInvalidPasswordAlert();
        return;
      } else {
        isLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isLoading(false);
      
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isLoading(false);
      print(e);
      ApiException().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
