import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class TechnicalSupportController extends GetxController {
  GlobalKey<FormState> technicalSupportFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  void onInit() async {
    sanctumToken = await storage.read(key: 'token');
    super.onInit();
  }

  var isLoading = false.obs;

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الاسم الرباعي';
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
      return 'يجب ادخال بريدك الإلكتروني';
    } else if (!GetUtils.isEmail(value)) {
      return 'يجب إدخال البريد الإلكتروني بشكل صحيح';
    }
    return null;
  }

/////////////

  TextEditingController messageController = TextEditingController();
  String? messageValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال نص الرسالة';
    }
    return null;
  }

  Future<void> sendMsg() async {
    try {
      isLoading(true);

      var response = await http.post(
        Uri.parse(ApiEndpoints.sendMsg),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'message': messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        isLoading(false);

        myShowDialog(
          context: Get.context!,
          widgetName: ApiExceptionAlert(
            height: 280,
            backgroundColor: MyColors.primaryColor,
            imageUrl: 'assets/images/success.json',
            title: 'تم الإرسال بنجاح',
            description:
                'شكراً لك على تواصلك معنا، سوف يتم الرد عليك في أقرب وقت ممكن',
            onPressed: () {
              Get.back();
            },
          ),
        );
        return;
      } else {
        isLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
        return;
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
