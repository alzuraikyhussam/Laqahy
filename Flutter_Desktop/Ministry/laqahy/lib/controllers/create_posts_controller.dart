import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostsController extends GetxController {
  GlobalKey<FormState> createPostsFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  String? titleValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال عنوان المنشور';
    }
    return null;
  }

  /////////////////
  TextEditingController pictureController = TextEditingController();

  String? pictureValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى اختيار صورة المنشور';
    }
    return null;
  }

  /////////////////
  TextEditingController descController = TextEditingController();

  String? descValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال وصف للمنشور';
    } else if (!GetUtils.isLengthGreaterOrEqual(value, 150)) {
      return 'يجب ألا يقل عن 150 حرف على الأقل';
    }
    return null;
  }
}
