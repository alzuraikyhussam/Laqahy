import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/services/storage/storage_service.dart';
import 'package:laqahy/view/screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  StorageService ss = StorageService();
  await ss.init();
  final bool? isDark = await ss.isDarkMode();
  print(isDark);

  await windowManager.ensureInitialized();
  appWindow.show();

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});

  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: isDark == null
          ? Constants().lightTheme
          : (isDark! ? Constants().darkTheme : Constants().lightTheme),
      builder: (context, myTheme) {
        return GetMaterialApp(
          defaultTransition: Transition.fade,
          initialBinding: BindingsBuilder(() {
            Get.put(StaticDataController());
          }),
          title: 'لقـاحي',
          theme: myTheme,
          themeMode: ThemeMode.system,
          // theme:

          // ThemeData(
          //   colorScheme:
          //       ColorScheme.fromSeed(seedColor: MyColors.secondaryColor),
          //   fontFamily: 'Tajawal',
          //   scaffoldBackgroundColor: Colors.white,
          //   appBarTheme: AppBarTheme(
          //     backgroundColor: Colors.white,
          //     scrolledUnderElevation: 0,
          //     iconTheme: CupertinoIconThemeData(color: MyColors.blackColor),
          //   ),
          //   useMaterial3: true,
          // ),
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
      },
    );
  }
}
