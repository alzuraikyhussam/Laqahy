import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  StaticDataController controller = Get.find<StaticDataController>();

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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/splash-logo.png',
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  controller.isRegistered.value
                      ? 'مرحبــاً بعــودتك ...'
                      : 'مرحبــاً بكــم ...',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                controller.isRegistered.value
                    ? Container(
                        width: 320,
                        child: Text(
                          'أهلاً وسهلاً بك في البرنامج الأول لمتابعة عملية التطعيم في اليمن.',
                          style: MyTextStyles.font18BlackBold,
                        ),
                      )
                    : Container(
                        width: 250,
                        child: Text(
                          'في البرنامج الأول لمتابعة عملية التطعيم في اليمن.',
                          style: MyTextStyles.font18BlackBold,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                controller.isRegistered.value
                    ? myButton(
                        width: 150,
                        onPressed: () {
                          Get.off(const LoginScreen());
                        },
                        text: 'تسجيـل دخـول',
                        textStyle: MyTextStyles.font16WhiteBold,
                      )
                    : Row(
                        children: [
                          myButton(
                            width: 150,
                            onPressed: () {
                              Get.off(const LoginScreen());
                            },
                            text: 'تسجيـل دخـول',
                            textStyle: MyTextStyles.font16WhiteBold,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          myButton(
                            width: 150,
                            backgroundColor: MyColors.greyColor,
                            onPressed: () {
                              // Get.off(const CreateMinistryAccountScreen());
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
