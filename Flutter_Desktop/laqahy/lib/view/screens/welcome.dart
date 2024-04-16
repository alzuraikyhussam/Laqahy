import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/create_account.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions welcomeWindowOptions = const WindowOptions(
      size: Size(850, 500),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(welcomeWindowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setTitle('لقــاحي | مرحباً بكم');
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/welcome-image.png",
              width: 400,
            ),
          ),
          myCopyRightText(),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myAppBarLogo(),
                    exitButton(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/splash-logo.png',
                    width: 300,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'مرحبــاً بكــم ...',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: Text(
                    'في البرنامج الأول لمتابعة عملية التطعيم في اليمن.',
                    style: MyTextStyles.font16BlackBold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    myButton(
                      width: 150,
                      onPressed: () {
                        Get.off(LoginScreen());
                      },
                      text: 'تسجيـل دخـول',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    myButton(
                      width: 150,
                      backgroundColor: MyColors.greyColor,
                      onPressed: () {
                        Get.off(CreateAccountScreen());
                      },
                      text: 'إنشـاء حسـاب',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
