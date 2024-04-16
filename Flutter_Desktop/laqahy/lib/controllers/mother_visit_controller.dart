import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MotherVisitController extends GetxController {
  
  
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    dosageLevelSearchController.close();
  }

  String? dosageLevelSelectedValue;

  final Rx<TextEditingController> dosageLevelSearchController =
      TextEditingController().obs;

  final List<String> dosageLevels = [
    'بعد الولادة',
    'في عمر 3 أشهر ونصف',
  ];

  changeDosageLevelSelectedValue(String selectedValue) {
    dosageLevelSelectedValue = selectedValue;
    update();
  }
}
