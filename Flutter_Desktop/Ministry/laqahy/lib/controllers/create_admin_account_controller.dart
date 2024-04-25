import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateAdminAccountController extends GetxController {
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
