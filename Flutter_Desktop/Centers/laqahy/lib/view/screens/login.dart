import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/login_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StaticDataController controller = Get.find<StaticDataController>();
  LoginController lc = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myAppBarLogo(),
                        controller.isRegistered.value
                            ? exitButton()
                            : goBackButton(
                                onTap: () {
                                  Get.off(const WelcomeScreen());
                                },
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() => Text(
                          '${controller.greeting.value} ...',
                          style: MyTextStyles.font18PrimaryBold,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        'أدخل اسم المستخدم وكلمة المرور لتسجيل الدخول.',
                        style: MyTextStyles.font16BlackBold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: lc.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myTextField(
                            autofocus: true,
                            validator: lc.userNameValidator,
                            controller: lc.userNameController,
                            width: 300,
                            prefixIcon: Icons.person_2_outlined,
                            hintText: 'اسم المستخدم',
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Obx(() {
                            return myTextField(
                              width: 300,
                              prefixIcon: Icons.password,
                              obscureText: lc.isVisible.value ? false : true,
                              validator: lc.passwordValidator,
                              controller: lc.passwordController,
                              suffixIcon: lc.isVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              hintText: 'كلمة المرور',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {},
                              onTapSuffixIcon: () {
                                lc.changePasswordVisibility();
                              },
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return lc.isLoading.value
                                ? myLoadingIndicator()
                                : myButton(
                                    onPressed: lc.isLoading.value
                                        ? null
                                        : () {
                                            if (lc.loginFormKey.currentState!
                                                .validate()) {
                                              lc.login();
                                            }
                                          },
                                    width: 150,
                                    text: 'تسجيـل دخـول',
                                    textStyle: MyTextStyles.font16WhiteBold,
                                  );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
