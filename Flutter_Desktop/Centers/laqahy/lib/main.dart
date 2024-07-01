import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/splash_screen.dart';

import 'package:window_manager/window_manager.dart';

import 'controllers/static_data_controller.dart';

// import 'view/screens/create_admin_account.dart';

// import 'package:laqahy/view/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await windowManager.ensureInitialized();

  WindowOptions splashWindowOptions = const WindowOptions(
    size: Size(700, 450),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(splashWindowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.setAlwaysOnTop(true);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      initialBinding: BindingsBuilder(() {
        Get.put(StaticDataController());
      }),
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
      scrollBehavior: const CupertinoScrollBehavior().copyWith(
        scrollbars: false,
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AL"),
      home: const SplashScreen(),
    );
  }
}
