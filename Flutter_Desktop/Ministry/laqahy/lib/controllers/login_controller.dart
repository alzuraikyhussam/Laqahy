import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isVisible = false.obs;
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
    if (value.trim().isEmpty) {
      return 'يرجى ادخال كلمة المرور';
    }
    return null;
  }
}
