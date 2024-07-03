// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/register_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/layouts/home/home_layout.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateAccountController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    StaticDataController controller = Get.find<StaticDataController>();
    controller.fetchCities();
    controller.fetchGenders();
    super.onInit();
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
      return 'يجب ادخال الاسم الرباعي';
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
      return 'يجب ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9 ارقام';
    }
    return null;
  }

/////////////
  TextEditingController birthDateController = TextEditingController();
  String? birthDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  //////////
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
      return 'يجب ادخال العنوان';
    }
    return null;
  }

  ////////

  Future<void> createAccount() async {
    StaticDataController sdc = Get.find<StaticDataController>();
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);

    try {
      isLoading(true);
      int centerId = sdc.centerData.first.id!;

      final register = Register(
        userName: nameController.text,
        userPhone: phoneNumberController.text,
        userBirthDate: parsedBirthDate,
        userAddress: addressController.text,
        userGenderId: sdc.selectedGenderId.value!,
        userPermissionId: 1,
        userAccountName: userNameController.text,
        userPassword: passwordController.text,
        centerId: centerId,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(register.toJson()),
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
          Get.offAll(const LoginScreen());
          return;
        }
        Constants().playSuccessSound();
        myShowDialog(
          context: Get.context!,
          widgetName: ApiExceptionAlert(
            height: 280,
            backgroundColor: MyColors.primaryColor,
            imageUrl: 'assets/images/success.json',
            title: 'تمت العملية بنجاح',
            description: 'لقد تمت عملية إنشاء الحساب بنجاح',
            onPressed: () {
              Get.offAll(const HomeLayout());
            },
          ),
        );

        return;
      } else if (response.statusCode == 401) {
        isLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
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
