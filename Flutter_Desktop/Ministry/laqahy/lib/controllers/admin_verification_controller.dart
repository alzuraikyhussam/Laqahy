import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminVerificationController extends GetxController {
  GlobalKey<FormState> adminVerificationFormKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  String? codeValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال كود التحقق';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 10)) {
      return 'يجب ألا يقل عن 10 ارقام وحروف';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'يجب ألا يحتوي على رموز او أحرف عربية';
    }
    return null;
  }

  RxBool isVisible = false.obs;

  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }
}
