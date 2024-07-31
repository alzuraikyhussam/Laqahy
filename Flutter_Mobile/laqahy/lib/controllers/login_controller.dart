import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/mother_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/layouts/home_layout.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    loadSettings();
    super.onInit();
  }

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  RxBool isVisible = false.obs;
  var isLoading = false.obs;
  var isLoginWithFingerprintLoading = false.obs;
  StaticDataController sdc = Get.put(StaticDataController());

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  changePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  TextEditingController idNumberController = TextEditingController();
  String? idNumberValidator(Value) {
    if (Value.trim().isEmpty) {
      return 'يجب ادخال الرقم الوطني';
    } else if (!GetUtils.isNumericOnly(Value)) {
      return 'يجب ادخال الرقم الوطني بشكل صحيح';
    }
    return null;
  }
  /////////

  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب ألا تقل عن 8 أحرف';
    }
    return null;
  }

  Future<void> login() async {
    StaticDataController sdc = Get.put(StaticDataController());
    try {
      isLoading(true);

      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        print(fcmToken);
        try {
          final loginData = Login(
            identityNum: idNumberController.text,
            passWord: passwordController.text,
            token: fcmToken,
          );
          var response = await http.post(
            Uri.parse(ApiEndpoints.login),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(loginData.toJson()),
          );

          if (response.statusCode == 200) {
            var data = json.decode(response.body);

            await storage.write(key: 'token', value: data['token']);

            MotherData user = MotherData.fromJson(data);

            sdc.userLoggedData.assignAll([user]);

            int? motherId = sdc.userLoggedData.first.user.id;

            sdc.storageService.setMotherId(motherId!);

            await Get.closeCurrentSnackbar();

            Get.offAll(
              () => const HomeLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            );
            isLoading(false);
            Get.delete<LoginController>();
            return;
          } else if (response.statusCode == 404) {
            isLoading(false);
            ApiExceptionWidgets().myDataIncorrectAlert();
            return;
          } else if (response.statusCode == 401) {
            isLoading(false);
            ApiExceptionWidgets().myInvalidPasswordAlert();
            return;
          } else {
            isLoading(false);
            ApiExceptionWidgets()
                .myAccessDatabaseExceptionAlert(response.statusCode);
            return;
          }
        } on SocketException catch (_) {
          isLoading(false);
          ApiExceptionWidgets().mySocketExceptionAlert();

          return;
        } catch (e) {
          isLoading(false);
          ApiExceptionWidgets().mySocketExceptionAlert();
        } finally {
          isLoading(false);
        }
      } else {
        isLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();

      return;
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } finally {
      isLoading(false);
    }
  }

  RxBool isFingerprintEnabled = false.obs;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> loadSettings() async {
    isFingerprintEnabled.value =
        await sdc.storageService.isFingerprintEnabled();
  }

  Future<void> toggleFingerprint(bool value) async {
    isFingerprintEnabled.value = value;
    sdc.storageService.setFingerprintEnabled(value);
  }

  Future<void> checkBiometrics() async {
    if (!isFingerprintEnabled.value) {
      showFingerprintNotEnabledInAppDialog();
    } else {
      loginWithFingerprint();
    }
  }

  Future<void> loginWithFingerprint() async {
    StaticDataController sdc = Get.put(StaticDataController());
    bool authenticated = false;
    try {
      isLoginWithFingerprintLoading(true);
      authenticated = await auth.authenticate(
        localizedReason: 'امسح بصمتك للتحقق',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      isLoginWithFingerprintLoading(false);
      authenticated = false;
    }

    if (!authenticated) {
      isLoginWithFingerprintLoading(false);
      await Get.closeCurrentSnackbar();
      Get.back();
      Get.snackbar(
        'خطــــــأ',
        'لقد حدث خطأ ما اثناء عملية مسح البصمة.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 10),
        icon: Lottie.asset(
          'assets/images/error.json',
          // alignment: Alignment.center,
          // fit: BoxFit.cover,
        ),
      );
    } else {
      try {
        isLoginWithFingerprintLoading(true);
        final fcmToken = await FirebaseMessaging.instance.getToken();
        int? motherId = await sdc.storageService.getMotherId();
        if (fcmToken != null) {
          var response = await http.post(
            Uri.parse(ApiEndpoints.loginWithFingerprint),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'mother_id': motherId, 'token': fcmToken}),
          );

          if (response.statusCode == 200) {
            var data = json.decode(response.body);

            await storage.write(key: 'token', value: data['token']);

            MotherData user = MotherData.fromJson(data);

            sdc.userLoggedData.assignAll([user]);

            toggleFingerprint(true);

            await Get.closeCurrentSnackbar();

            Get.offAll(
              () => const HomeLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            );

            isLoginWithFingerprintLoading(false);
            Get.delete<LoginController>();

            return;
          } else {
            isLoginWithFingerprintLoading(false);
            ApiExceptionWidgets()
                .myAccessDatabaseExceptionAlert(response.statusCode);
            return;
          }
        } else {
          isLoginWithFingerprintLoading(false);
          ApiExceptionWidgets().mySocketExceptionAlert();
        }
      } on SocketException catch (_) {
        isLoginWithFingerprintLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();

        return;
      } catch (e) {
        isLoginWithFingerprintLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } finally {
        isLoginWithFingerprintLoading(false);
      }
    }
  }

  void showFingerprintNotEnabledInAppDialog() async {
    await Get.closeCurrentSnackbar();
    Get.back();
    Get.snackbar(
      'البصمة غير مفعلة',
      'يجب تفعيل البصمة أولاً من خلال اعدادات التطبيق.',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }
}
