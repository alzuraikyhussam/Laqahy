import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
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
      var officeId = await sdc.storageService.getOfficeId();
      var response = await http.post(
        Uri.parse('${ApiEndpoints.login}/$officeId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData.toJson()),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Handle user and center objects
        Login user = Login.fromJson(data['user']);
        Office center = Office.fromJson(data['office']);

        sdc.userLoggedData.assignAll([user]);
        sdc.officeData.assignAll([center]);

        try {
          // Save SharedPreferences
          if (!await sdc.storageService.isRegistered()) {
            await sdc.storageService.setOfficeId(sdc.officeData.first.id!);
            await sdc.storageService
                .setAdminId(sdc.userLoggedData.first.userId!);
            await sdc.storageService.setRegistered(true);
          }
          Get.offAll(const HomeLayout());
          isLoading(false);
        } catch (e) {
          isLoading(false);
          ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
        }

        return;
      } else if (response.statusCode == 402) {
        isLoading(false);
        ApiExceptionWidgets().myUserNotFoundInThisOfficeAlert();
        return;
      } else if (response.statusCode == 404) {
        isLoading(false);
        ApiExceptionWidgets().myUserNotFoundAlert();
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
