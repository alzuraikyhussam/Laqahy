import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/onboarding_layout.dart';
import 'package:laqahy/view/screens/Notification_page.dart';
import 'package:laqahy/view/screens/children_vaccine.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/home_layout.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/mother_vaccine.dart';
import 'package:laqahy/view/screens/onboarding_screens/awareness_information.dart';
import 'package:laqahy/view/screens/onboarding_screens/create_new_password.dart';
import 'package:laqahy/view/screens/onboarding_screens/first_onboarding.dart';
import 'package:laqahy/view/screens/profile.dart';
import 'package:laqahy/view/screens/splash_screen.dart';

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
      home: ChildrenVaccine(),
    );
  }
}
