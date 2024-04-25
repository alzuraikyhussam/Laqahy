import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:laqahy/view/widgets/admin_verification.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions loginWindowOptions = const WindowOptions(
      size: Size(800, 500),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(loginWindowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setTitle('لقــاحي | تسجيل دخول');
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
            left: 10,
            bottom: 0,
            top: 0,
            child: SvgPicture.asset(
              'assets/images/login.svg',
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
                    goBackButton(
                      onTap: () {
                        Get.off(WelcomeScreen());
                      },
                    ),
                    exitButton(),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'صبـاح الخيــر ...',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: Text(
                    'أدخل اسم المستخدم وكلمة المرور لتسجيل الدخول.',
                    style: MyTextStyles.font14BlackBold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                myTextField(
                  width: 300,
                  prefixIcon: Icons.person_2_outlined,
                  hintText: 'اسم المستخدم',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 15,
                ),
                myTextField(
                  width: 300,
                  prefixIcon: Icons.password,
                  obscureText: true,
                  suffixIcon: Icons.visibility_off_outlined,
                  hintText: 'كلمة المرور',
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                myButton(
                  onPressed: () {
                    myShowDialog(
                        context: context, widgetName: AdminVerification());
                  },
                  width: 150,
                  text: 'تسجيـل دخـول',
                  textStyle: MyTextStyles.font16WhiteBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
