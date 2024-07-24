import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
            await Get.closeCurrentSnackbar();

            var data = json.decode(response.body);

            MotherData user = MotherData.fromJson(data);

            sdc.userLoggedData.assignAll([user]);

            int? motherId = sdc.userLoggedData.first.user.id;

            sdc.storageService.setMotherId(motherId!);

            Get.offAll(
              () => const HomeLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 3000),
              curve: Curves.fastLinearToSlowEaseIn,
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
      isFingerprintEnabled.value = false;
      toggleFingerprint(false);
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
            isLoginWithFingerprintLoading(false);

            var data = json.decode(response.body);

            MotherData user = MotherData.fromJson(data);

            sdc.userLoggedData.assignAll([user]);

            toggleFingerprint(true);

            Get.offAll(
              () => const HomeLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 3000),
              curve: Curves.fastLinearToSlowEaseIn,
            );
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

  // Future<void> loginWithFingerprint() async {
  //   try {
  //     SettingsController sc = Get.put(SettingsController());

  //     await sc.checkBiometricAvailability();

  //     if (!sc.isFingerprintAvailable.value) {
  //       await Get.closeCurrentSnackbar();
  //       Get.snackbar(
  //         'خطــــــأ',
  //         sc.statusMsg.value,
  //         snackPosition: SnackPosition.TOP,
  //         duration: const Duration(seconds: 10),
  //         icon: Lottie.asset(
  //           'assets/images/error.json',
  //           // alignment: Alignment.center,
  //           // fit: BoxFit.cover,
  //         ),
  //       );
  //       return;
  //     }

  //     await FlutterBiometrics().createKeys(reason: 'التحقق من البصمة');

  //     String payload = 'payload_to_sign';
  //     String payloadBase64 = base64Encode(utf8.encode(payload));

  //     String? biometricData = await FlutterBiometrics().sign(
  //       payload: payloadBase64,
  //       reason: 'التحقق من البصمة',
  //     );

  //     if (biometricData != null) {
  //       await verifyFingerprint(biometricData);
  //     }
  //   } catch (e) {
  //     await Get.closeCurrentSnackbar();
  //     Get.snackbar(
  //       'خطــــــأ',
  //       'فشل في عملية التحقق من البصمة.',
  //       snackPosition: SnackPosition.TOP,
  //       duration: const Duration(seconds: 10),
  //       icon: Lottie.asset(
  //         'assets/images/error.json',
  //         // alignment: Alignment.center,
  //         // fit: BoxFit.cover,
  //       ),
  //     );
  //   }
  // }

  // Future<void> verifyFingerprint(String biometricData) async {
  //   bool hasEnabledFingerprint =
  //       await sdc.storageService.isFingerprintEnabled();

  //   if (hasEnabledFingerprint) {
  //     try {
  //       final fcmToken = await FirebaseMessaging.instance.getToken();
  //       if (fcmToken != null) {
  //         try {
  //           isLoginWithFingerprintLoading(true);
  //           var response = await http.post(
  //             Uri.parse(ApiEndpoints.loginWithFingerprint),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json',
  //             },
  //             body: json.encode({
  //               'fingerprint': biometricData,
  //               'token': fcmToken,
  //             }),
  //           );
  //           if (response.statusCode == 200) {
  //             var data = json.decode(response.body);

  //             MotherData user = MotherData.fromJson(data);

  //             sdc.userLoggedData.assignAll([user]);

  //             await Get.closeCurrentSnackbar();

  //             Get.offAll(
  //               () => const HomeLayout(),
  //               transition: Transition.rightToLeft,
  //               duration: const Duration(milliseconds: 3000),
  //               curve: Curves.fastLinearToSlowEaseIn,
  //             );

  //             isLoginWithFingerprintLoading(false);

  //             Get.delete<LoginController>();
  //             Get.delete<SettingsController>();
  //           } else if (response.statusCode == 404) {
  //             ApiExceptionWidgets().myDataIncorrectAlert();
  //             isLoginWithFingerprintLoading(false);
  //             return;
  //           } else {
  //             ApiExceptionWidgets()
  //                 .myAccessDatabaseExceptionAlert(response.statusCode);
  //             isLoginWithFingerprintLoading(false);
  //             return;
  //           }
  //         } on SocketException catch (_) {
  //           ApiExceptionWidgets().mySocketExceptionAlert();
  //           isLoginWithFingerprintLoading(false);

  //           return;
  //         } catch (e) {
  //           ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
  //           isLoginWithFingerprintLoading(false);
  //         }
  //       } else {
  //         ApiExceptionWidgets().mySocketExceptionAlert();
  //         isLoginWithFingerprintLoading(false);
  //       }
  //     } on SocketException catch (_) {
  //       ApiExceptionWidgets().mySocketExceptionAlert();
  //       isLoginWithFingerprintLoading(false);

  //       return;
  //     } catch (e) {
  //       ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
  //       isLoginWithFingerprintLoading(false);
  //     }
  //   } else {
  //     await Get.closeCurrentSnackbar();
  //     myShowDialog(
  //       context: Get.context!,
  //       widgetName: ApiExceptionAlert(
  //         title: 'خطــــــأ',
  //         description: 'يجب القيام بعملية تفعيل البصمة أولاً',
  //         backgroundColor: MyColors.redColor,
  //         height: 280,
  //         imageUrl: 'assets/images/error.json',
  //       ),
  //     );
  //   }
  // }
}
