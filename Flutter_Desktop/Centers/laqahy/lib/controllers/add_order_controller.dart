import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrderController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    vaccineTypeSearchController.close();
  }

  String? vaccineTypeSelectedValue;

  final Rx<TextEditingController> vaccineTypeSearchController =
      TextEditingController().obs;

  final List<String> vaccineTypes = [
    'السل',
    'الخماسي',
  ];

  changeVaccineTypeSelectedValue(String selectedValue) {
    vaccineTypeSelectedValue = selectedValue;
    update();
  }
}
