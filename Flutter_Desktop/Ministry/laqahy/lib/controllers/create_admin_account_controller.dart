import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateAdminAccountController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    genderSearchController.close();
  }

  RxBool isVisible = false.obs;

  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

///////
  GlobalKey<FormState> createAdminAccountFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

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
  TextEditingController numberController = TextEditingController();
  String? numberValidator(value) {
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

/////////////
  String? genderValidator(value) {
    if (value == null) {
      return 'قم باختيار الجنس';
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
      return 'يجب أن تكون على الأقل 8 أحرف';
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

  String? genderSelectedValue;
  final Rx<TextEditingController> genderSearchController =
      TextEditingController().obs;

  final List<String> gender = [
    'ذكر',
    'انثى',
  ];

  changeGenderSelectedValue(String selectedValue) {
    genderSelectedValue = selectedValue;

    update();
  }
}
