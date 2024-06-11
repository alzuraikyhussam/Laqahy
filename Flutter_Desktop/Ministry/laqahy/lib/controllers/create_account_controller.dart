// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/register_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/user_models.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/services/storage/storage_service.dart';
import 'package:laqahy/view/layouts/home/home_layout.dart';
import 'package:laqahy/view/screens/login.dart';

class CreateAccountController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  var fetchDataFuture = Future<void>.value().obs;
  var isLoading = false.obs;

  RxBool isVisible = false.obs;

  GlobalKey<FormState> createAdminAccountFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  ///////

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال الاسم الرباعي';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يجب أن يحتوي الاسم على أرقام أو رموز';
    } else if (!RegExp(r'^\S+(\s+\S+){3}$').hasMatch(value)) {
      // Regular expression to match exactly four words separated by spaces
      return 'يجب ادخال اسمك الرباعي';
    }
    return null;
  }

/////////////
  TextEditingController phoneNumberController = TextEditingController();
  String? phoneNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9 ارقام';
    }
    return null;
  }

/////////////
  TextEditingController birthdateController = TextEditingController();
  String? birthdateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  //////////
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
      return 'يجب ألا تقل عن 8 أحرف';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]+$')
        .hasMatch(value)) {
      // Check for at least one uppercase letter, one lowercase letter, one digit, and one special character
      return 'يجب أن تحتوي على أحرف كبيرة\n وصغيرة وأرقام ورموز';
    }
    return null;
  }

  //////////
  TextEditingController addressController = TextEditingController();
  String? addressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال العنوان';
    }
    return null;
  }

  ////////

  //////////
  TextEditingController centerAddressController = TextEditingController();
  String? centerAddressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال العنوان';
    }
    return null;
  }

  ////////

  GlobalKey<FormState> createMinistryAccountFormKey = GlobalKey<FormState>();

  /////////////
  TextEditingController centerPhoneNumberController = TextEditingController();
  String? centerPhoneNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthBetween(value, 6, 9)) {
      return 'يجب أن يكون ما بين 6 الى 9 أرقام';
    }
    return null;
  }

  Future<void> createAccount() async {
    StaticDataController sdc = Get.find<StaticDataController>();
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthdateController.text);

    try {
      isLoading(true);
      // final deviceInfo = await sdc.initWindowsSystemInfo();
  
      final centerWithUser = Register(
        userName: nameController.text,
        userPhone: phoneNumberController.text,
        userAddress: addressController.text,
        userBirthDate: parsedBirthDate,
        userAccountName: userNameController.text,
        userPassword: passwordController.text,
        userGenderId: sdc.selectedGenderId.value!,
        userPermissionId: 1,
        centerName: 'وزارة الصحة والسكان',
        centerPhone: centerPhoneNumberController.text,
        centerAddress: centerAddressController.text,
        centerDirectorateId: sdc.selectedDirectorateId.value!,
        centerCityId: sdc.selectedCityId.value!,
        // deviceName: deviceInfo[1],
        // deviceUserName: deviceInfo[2],
        // deviceMacAddress: deviceInfo[0],
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(centerWithUser.toJson()),
      );

      if (response.statusCode == 201) {
        isLoading(false);

        var data = json.decode(response.body);

        // Handle user and center objects
        Login user = Login.fromJson(data['user']);
        HealthyCenter center = HealthyCenter.fromJson(data['center']);

        sdc.userLoggedData.assignAll([user]);
        sdc.centerData.assignAll([center]);

        try {
          // Save SharedPreferences
          await sdc.storageService.setCenterId(sdc.centerData.first.id!);
          await sdc.storageService.setAdminId(sdc.userLoggedData.first.userId!);
          await sdc.storageService.setRegistered(true);
        } catch (e) {
          Get.offAll(LoginScreen());
        }

        ApiException().myAddedDataSuccessAlert(
          onPressed: () {
            Get.offAll(HomeLayout());
          },
        );
        return;
      } else if (response.statusCode == 401) {
        isLoading(false);
        ApiException().myUserAlreadyExistsAlert();
        return;
      } else {
        isLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        print(response.body);
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
