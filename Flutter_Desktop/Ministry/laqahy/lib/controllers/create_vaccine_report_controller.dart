import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateVaccineReportController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    vaccineTypeSearchController.close();
    sourceSearchController.close();
  }

  GlobalKey<FormState> createVaccineReportFormKey = GlobalKey<FormState>();

  String? vaccineTypeSelectedValue;
  String? sourceSelectedValue;

  final Rx<TextEditingController> vaccineTypeSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> sourceSearchController =
      TextEditingController().obs;

  final List<String> vaccineTypes = [
    'السل',
    'الخماسي',
  ];

  final List<String> source = [
    'منظمة اليونيسيف',
    'الصليب الأحمر',
  ];

  changeVaccineTypeSelectedValue(String selectedValue) {
    vaccineTypeSelectedValue = selectedValue;
    update();
  }

  changeSourceSelectedValue(String selectedValue) {
    sourceSelectedValue = selectedValue;
    update();
  }

  String? vaccineTypeValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع اللقاح';
    }
    return null;
  }

  //////////
  String? sourceValidator(value) {
    if (value == null) {
      return 'قم باختيار الجهة المانحة';
    }
    return null;
  }

  //////////
  TextEditingController beginDateController = TextEditingController();
  String? beginDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ البداية';
    }
    return null;
  }

  //////////
  TextEditingController endDateController = TextEditingController();
  String? endDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ النهاية';
    }
    return null;
  }
}
