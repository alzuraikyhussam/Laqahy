import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    genderSearchController.close();
  }

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
