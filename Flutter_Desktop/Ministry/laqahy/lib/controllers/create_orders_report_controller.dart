import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOrdersReportController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    citySearchController.close();
    centerSearchController.close();
    orderStatusSearchController.close();
  }


  final Rx<TextEditingController> citySearchController =
      TextEditingController().obs;

  final Rx<TextEditingController> centerSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> orderStatusSearchController =
      TextEditingController().obs;

  String? citySelectedValue;
  String? centerSelectedValue;
  String? orderStatusSelectedValue;

  final List<String> cities = [
    'تعز',
    'عدن',
  ];

  final List<String> centers = [
    'مركز المظفر',
    'مركز التعاون',
  ];

  final List<String> orderStatus = [
    'الواردة',
    'تم التسليم',
    'قيد التسليم',
    'الملغية',
  ];

  changeCitySelectedValue(String selectedValue) {
    citySelectedValue = selectedValue;
    update();
  }

  changeCenterSelectedValue(String selectedValue) {
    centerSelectedValue = selectedValue;
    update();
  }

  changeOrderStatusSelectedValue(String selectedValue) {
    orderStatusSelectedValue = selectedValue;
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
  String? orderStatusValidator(value) {
    if (value == null) {
      return 'قم باختيار حالة الطلب';
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
