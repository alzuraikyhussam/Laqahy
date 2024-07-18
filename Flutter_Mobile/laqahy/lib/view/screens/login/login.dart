import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/login_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import 'package:laqahy/view/screens/reset_password.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController lc = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar(
        text: 'تسجيل دخول',
        showBackButton: false,
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: width,
                  child: myCarouselSlider(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: lc.loginFormKey,
                    child: Column(
                      children: [
                        myTextField(
                          controller: lc.idNumberController,
                          validator: lc.idNumberValidator,
                          labelText: 'الرقم الوطني',
                          prefixIcon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(() {
                          return myTextField(
                              controller: lc.passwordController,
                              validator: lc.passwordValidator,
                              labelText: 'كلمة المرور',
                              prefixIcon: Icons.password_outlined,
                              suffixIcon: lc.isVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: lc.isVisible.value ? false : true,
                              onChanged: (p0) {},
                              onTapSuffixIcon: () {
                                lc.changePasswordVisibility();
                              });
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: myTextButton(
                            text: 'نسيت كلمة المرور؟',
                            onPressed: () {
                              Get.to(const ResetPassword());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(child: Obx(
                              () {
                                return lc.isLoading.value
                                    ? myLoadingIndicator()
                                    : myButton(
                                        onPressed: lc.isLoading.value
                                            ? null
                                            : () {
                                                if (lc
                                                    .loginFormKey.currentState!
                                                    .validate()) {
                                                  lc.login();
                                                }
                                              },
                                        text: 'تسجيل دخول',
                                        textStyle: MyTextStyles.font14WhiteBold,
                                      );
                              },
                            )),
                            const SizedBox(
                              width: 15,
                            ),
                            myIconButton(
                              onPressed: () {},
                              icon: Icons.fingerprint_rounded,
                              backgroundColor: [
                                MyColors.secondaryColor,
                                MyColors.secondaryColor
                              ],
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
