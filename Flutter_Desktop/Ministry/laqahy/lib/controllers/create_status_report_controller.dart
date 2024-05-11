import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStatusReportController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    citySearchController.close();
    centerSearchController.close();
    statusTypeSearchController.close();
  }

  GlobalKey<FormState> createStatusReportFormKey = GlobalKey<FormState>();

  String? citySelectedValue;
  String? centerSelectedValue;
  String? statusTypeSelectedValue;

  final Rx<TextEditingController> citySearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> centerSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> statusTypeSearchController =
      TextEditingController().obs;

  final List<String> cities = [
    'تعز',
    'عدن',
  ];

  final List<String> centers = [
    'مركز المظفر',
    'مركز التعاون',
  ];

  final List<String> statusType = [
    'الأمهــات',
    'الأطـفــال',
  ];

  changeCitySelectedValue(String selectedValue) {
    citySelectedValue = selectedValue;
    update();
  }

  changeCenterSelectedValue(String selectedValue) {
    centerSelectedValue = selectedValue;
    update();
  }

  changeStatusTypeSelectedValue(String selectedValue) {
    statusTypeSelectedValue = selectedValue;
    update();
  }

  /////////////
  String? cityValidator(value) {
    if (value == null) {
      return 'قم باختيار المحافظة';
    }
    return null;
  }

  //////////
  String? centerNameValidator(value) {
    if (value == null) {
      return 'قم باختيار المركز الصحي';
    }
    return null;
  }

  //////////
  String? statusTypeValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع الحالة';
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
