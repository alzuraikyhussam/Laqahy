import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCentersReportController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    citySearchController.close();
    directorateSearchController.close();
  }

  GlobalKey<FormState> createCentersReportFormKey = GlobalKey<FormState>();

  final Rx<TextEditingController> citySearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> directorateSearchController =
      TextEditingController().obs;

  String? citySelectedValue;
  String? directorateSelectedValue;

  final List<String> cities = [
    'تعز',
    'عدن',
  ];

  final List<String> directorates = [
    'المظفر',
    'القاهرة',
  ];

  changeCitySelectedValue(String selectedValue) {
    citySelectedValue = selectedValue;
    update();
  }

  changeDirectorateSelectedValue(String selectedValue) {
    directorateSelectedValue = selectedValue;
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
  String? directorateValidator(value) {
    if (value == null) {
      return 'قم باختيار المديرية';
    }
    return null;
  }
  //////////
}
