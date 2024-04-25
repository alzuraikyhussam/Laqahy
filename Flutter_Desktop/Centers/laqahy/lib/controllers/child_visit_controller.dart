import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildVisitController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    visitTypeSearchController.close();
    vaccineTypeSearchController.close();
  }

  String? visitTypeSelectedValue;
  String? vaccineTypeSelectedValue;

  final Rx<TextEditingController> visitTypeSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> vaccineTypeSearchController =
      TextEditingController().obs;

  final List<String> visitTypes = [
    'بعد الولادة',
    'في عمر 3 أشهر ونصف',
  ];
  final List<String> vaccineTypes = [
    'السل',
    'الخماسي',
  ];

  changeVisitTypeSelectedValue(String selectedValue) {
    visitTypeSelectedValue = selectedValue;
    update();
  }

  changeVaccineTypeSelectedValue(String selectedValue) {
    vaccineTypeSelectedValue = selectedValue;
    update();
  }
}
