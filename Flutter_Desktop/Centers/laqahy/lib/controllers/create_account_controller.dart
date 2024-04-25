import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    directorateSearchController.close();
    citySearchController.close();
  }

  String? directorateSelectedValue;
  String? citySelectedValue;

  final Rx<TextEditingController> directorateSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> citySearchController =
      TextEditingController().obs;

  final List<String> directorates = [
    'المظفر',
    'القاهرة',
    'صالة',
  ];

  final List<String> cities = [
    'تعز',
    'عدن',
    'صنعاء',
  ];

  changeCitySelectedValue(String selectedValue) {
    citySelectedValue = selectedValue;
    
    update();
  }

  changeDirectorateSelectedValue(String selectedValue) {
    directorateSelectedValue = selectedValue;
     update();
  }
}
