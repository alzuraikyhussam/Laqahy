import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laqahy/view/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام لقاحي الذكي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        fontFamily: 'Tajawal',
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.primaryColor,
          iconTheme: CupertinoIconThemeData(color: MyColors.whiteColor),
        ),
        useMaterial3: true,

      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: CupertinoScrollBehavior(),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AL"),
      home: HomeScreen(),
    );
  }
}

