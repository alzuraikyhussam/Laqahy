import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicalSupportController extends GetxController {
  GlobalKey<FormState> technicalSupportFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال الاسم الرباعي';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يجب أن يحتوي الاسم على أرقام أو رموز';
    } else if (!RegExp(r'^\S+(\s+\S+){3}$').hasMatch(value)) {
      // Regular expression to match exactly four words separated by spaces
      return 'يجب ادخال اسمك الرباعي';
    }
    return null;
  }

/////////////

  TextEditingController emailController = TextEditingController();

  String? emailValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال بريدك الإلكتروني';
    } else if (!GetUtils.isEmail(value)) {
      return 'يرجى إدخال البريد الإلكتروني بشكل صحيح';
    }
    return null;
  }

/////////////

  TextEditingController messageController = TextEditingController();
  String? messageValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال نص الرسالة';
    }
    return null;
  }
}
