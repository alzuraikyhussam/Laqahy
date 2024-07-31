import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/settings_model.dart';
import 'package:laqahy/view/screens/reset_password/reset_password.dart';
import 'package:laqahy/view/screens/settings/enable_fingerprint_loading.dart';
import 'package:laqahy/view/widgets/basic_widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class SettingsController extends GetxController {
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  void onClose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.onClose();
  }

  // final LocalAuthentication auth = LocalAuthentication();
  // var statusMsg = ''.obs;
  // var isFingerprintAvailable = false.obs;

  PageController pageController = PageController();

  List<SettingsListItem> settingsListViewItems = [
    SettingsListItem(
      prefix: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.password_rounded,
          color: MyColors.primaryColor,
        ),
      ),
      label: 'تغيير كلمة المرور',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () {
        StaticDataController sdc = Get.put(StaticDataController());
        Get.to(
          () => ResetPassword(motherId: sdc.userLoggedData.first.user.id!),
        );
      },
    ),
    SettingsListItem(
      prefix: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.fingerprint_rounded,
          color: MyColors.primaryColor,
        ),
      ),
      label: 'تفعيل بصمة الأصبع',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () async {
        SettingsController sc = Get.put(SettingsController());
        myShowDialog(
          context: Get.context!,
          widgetName: const EnableFingerprintLoading(),
        );
        sc.checkBiometrics();
        // myShowDialog(
        //   context: Get.context!,
        //   widgetName: ApiExceptionAlert(
        //     title: 'الميزة غير متوفرة حالياً',
        //     description:
        //         'عذراً، هذه الميزة غير متوفرة حالياً، سيتم تفعيلها قريباً في التحديثات القادمة',
        //     backgroundColor: MyColors.primaryColor,
        //     height: 300,
        //     imageUrl: 'assets/images/warning.json',
        //   ),
        // );
      },
    ),
    // SettingsListItem(
    //   prefix: Container(
    //     width: 45,
    //     height: 45,
    //     decoration: BoxDecoration(
    //         color: MyColors.primaryColor.withOpacity(0.2),
    //         borderRadius: BorderRadius.circular(50)),
    //     child: Icon(
    //       Icons.dark_mode_outlined,
    //       color: MyColors.primaryColor,
    //     ),
    //   ),
    //   label: 'الوضع المظلم',
    //   suffix: mySwitchButton(),
    //   onTap: () {},
    // ),
    SettingsListItem(
      prefix: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: MyColors.redColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.logout_outlined,
          color: MyColors.redColor,
        ),
      ),
      label: 'تسجيل خروج',
      suffix: Icon(
        Icons.arrow_back_ios_new_rounded,
        textDirection: TextDirection.ltr,
        size: 20,
        color: MyColors.greyColor,
      ),
      onTap: () {
        myShowDialog(
          barrierDismissible: true,
          context: Get.context!,
          widgetName: myLogoutConfirmDialog(),
        );
      },
    ),
  ];

  RxBool isFingerprintEnabled = false.obs;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> toggleFingerprint(bool value) async {
    isFingerprintEnabled.value = value;
    sdc.storageService.setFingerprintEnabled(value);
  }

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }

    List<BiometricType> availableBiometricTypes =
        await auth.getAvailableBiometrics();

    if (availableBiometricTypes.isEmpty) {
      showBiometricNotAvailableDialog();
    } else if (!canCheckBiometrics) {
      showBiometricNotEnabledDialog();
    } else {
      createFingerprint();
    }
  }

  Future<void> createFingerprint() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'الرجاء المصادقة لتفعيل البصمة',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      authenticated = false;
    }

    if (!authenticated) {
      await Get.closeCurrentSnackbar();
      Get.back();
      Get.snackbar(
        'خطــــــأ',
        'لقد حدث خطأ ما اثناء عملية تفعيل البصمة.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 10),
        icon: Lottie.asset(
          'assets/images/error.json',
          // alignment: Alignment.center,
          // fit: BoxFit.cover,
        ),
      );
      Get.back();
      isFingerprintEnabled.value = false;
      toggleFingerprint(false);
    } else {
      await Get.closeCurrentSnackbar();
      Get.back();
      myShowDialog(
        context: Get.context!,
        widgetName: ApiExceptionAlert(
          title: 'تمت العملية بنجاح',
          description: 'لقد تمت عملية تفعيل البصمة بنجاح',
          backgroundColor: MyColors.primaryColor,
          height: 280,
          imageUrl: 'assets/images/success.json',
        ),
      );
      toggleFingerprint(true);
    }
  }

  void showBiometricNotEnabledDialog() async {
    await Get.closeCurrentSnackbar();
    Get.back();
    Get.snackbar(
      'خطــــــأ',
      'يجب تفعيل البصمة في جهازك أولاً.',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 10),
      icon: Lottie.asset(
        'assets/images/error.json',
        // alignment: Alignment.center,
        // fit: BoxFit.cover,
      ),
    );
  }

  void showBiometricNotAvailableDialog() async {
    await Get.closeCurrentSnackbar();
    Get.back();
    Get.snackbar(
      'خطــــــأ',
      'جهازك لا يدعم البصمة.',
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
