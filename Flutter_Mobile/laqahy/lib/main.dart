import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/firebase_options.dart';
import 'package:laqahy/services/firebase/firebase_api.dart';
import 'package:laqahy/view/screens/notification_page.dart';
import 'package:laqahy/view/screens/reset_password.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/screens/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
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
      home: ResetPasswordVerification(),
      navigatorKey: navigatorKey,
      routes: {
        '/notifications_screen': (context) => const NotificationScreen(),
      },
    );
  }
}
