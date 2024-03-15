import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'لقـاحي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondaryColor),
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
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
      home: HomeScreen(),
    );
  }
}
