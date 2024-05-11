import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQtyVaccineController extends GetxController {
  GlobalKey<FormState> addQtyVaccineFormKey = GlobalKey<FormState>();

  TextEditingController sourceController = TextEditingController();
  String? sourceValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال اسم الجهة المانحة ';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يمكن ادخال ارقام او رموز';
    }
    return null;
  }

  /////////////
  TextEditingController qtyController = TextEditingController();
  String? qtyValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال الكمية';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    }
    return null;
  }
}
