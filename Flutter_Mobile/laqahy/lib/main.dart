import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/home_layout.dart';
import 'package:laqahy/view/screens/Notification_page.dart';
import 'package:laqahy/view/screens/awareness_information.dart';
import 'package:laqahy/view/screens/choose_children.dart';
import 'package:laqahy/view/screens/contact_us.dart';
import 'package:laqahy/view/screens/create_new_pass.dart';
import 'package:laqahy/view/screens/exampel.dart';
import 'package:laqahy/view/screens/exit_app_confirm.dart';
import 'package:laqahy/view/screens/fingerprint_check.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/logout.dart';
import 'package:laqahy/view/screens/mother_vaccine.dart';
import 'package:laqahy/view/screens/profile.dart';
import 'package:laqahy/view/screens/reset_password.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/screens/settings_page.dart';
import 'package:laqahy/view/screens/splash_screen.dart';
import 'package:laqahy/view/screens/successfull_send_messeg.dart';
import 'package:laqahy/view/screens/successfully_chang_pass.dart';
import 'package:laqahy/view/screens/successfully_login.dart';

import 'view/screens/child_vaccine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      // initialBinding: BindingsBuilder(() {
      //   Get.put(StaticDataController());
      // }),
      title: 'لقـاحي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondaryColor),
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 41, 20, 20),
          scrolledUnderElevation: 0,
          iconTheme: CupertinoIconThemeData(color: MyColors.blackColor),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior(),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AL"),
      home: SplashScreen(),
    );
  }
}
