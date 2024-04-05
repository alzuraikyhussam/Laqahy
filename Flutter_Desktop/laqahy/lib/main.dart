import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:laqahy/core/shared/styles/color.dart';

import 'package:laqahy/view/widgets/basic_widgets/add_employ.dart';
import 'package:laqahy/view/widgets/basic_widgets/edit_child_state.dart';

// import 'view/screens/create_admin_account.dart';

import 'view/widgets/basic_widgets/add_child_state.dart';
import 'view/widgets/basic_widgets/add_mother_state.dart';
import 'view/widgets/basic_widgets/child_visit_data.dart';
import 'view/screens/create_account.dart';
import 'view/screens/employees.dart';
import 'view/widgets/basic_widgets/mother_visit_data.dart';
import 'view/widgets/basic_widgets/techincal_support.dart';
import 'view/screens/visits.dart';
import 'view/widgets/basic_widgets/delete_employ_confirm.dart';
import 'view/widgets/basic_widgets/delete_post_confirm.dart';
import 'view/widgets/basic_widgets/logout_confirm.dart';
import 'view/widgets/basic_widgets/main_page.dart';
import 'view/widgets/basic_widgets/send_support_successfully.dart';
import 'view/widgets/basic_widgets/state_details.dart';
import 'view/widgets/basic_widgets/successfully_add_state.dart';
import 'view/widgets/basic_widgets/successfully_edit_state.dart';
// import 'package:laqahy/view/screens/home.dart';

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
      home: EditeChildState(),
    );
  }
}
