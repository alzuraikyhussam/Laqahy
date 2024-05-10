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

///////
  GlobalKey<FormState> createAccountFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  String? nameValidator(value) {
    if (value.isEmpty) {
      return 'يرجى ادخال الاسم الرباعي';
    }

    return null;
  }

/////////////
  TextEditingController numberController = TextEditingController();
  String? numberValidator(value) {
    if (value.isEmpty) {
      return 'يرجى ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9  ارقام';
    }
    return null;
  }

/////////////
  TextEditingController genderController = TextEditingController();
  String? dateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  TextEditingController dateController = TextEditingController();
  String? genderValidator(value) {
    if (value.isEmpty) {
      return 'قم بأختيار الجنس';
    }
    return null;
  }

//////////
  TextEditingController userNameController = TextEditingController();
  String? userNameValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال اسم المستخدم';
    } else if (!GetUtils.isUsername(value)) {
      return 'يرجى ادخال اسم مستخدم صالح';
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
