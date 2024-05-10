import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMinistryAccountController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    directorateSearchController.close();
    citySearchController.close();
  }
    GlobalKey<FormState> createMinistryAccountFormKey = GlobalKey<FormState>();

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

  /////////////
  TextEditingController numberController = TextEditingController();
  String? numberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9 ارقام';
    }
    return null;
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
  TextEditingController addressController = TextEditingController();
  String? addressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال العنوان';
    }
    return null;
  }
}
