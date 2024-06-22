import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/login_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/reset_password.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginController lc = Get.put(LoginController());
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: MyColors.greyColor,
                  width: width,
                  child: myCarouselSlider(),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: lc.loginFormKey,
                    child: Column(
                      children: [
                        myTextField(
                          controller: lc.idNumberController,
                          validator: lc.idNumberValidator,
                          labelText: 'أدخل الرقم الوطني',
                          prefixIcon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        myTextField(
                          controller: lc.passwordController,
                          validator: lc.passwordValidator,
                          labelText: 'كلمة المرور',
                          prefixIcon: Icons.password_outlined,
                          suffixIcon: Icons.visibility_off_outlined,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (p0) {},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: myTextButton(
                            text: 'نسيت كلمة المرور؟',
                            onPressed: () {
                              Get.to(ResetPassword());
                            },
                          ),
                        ),
                        SizedBox(
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
                                                  // myAwesomeDialog(
                                                  //   context: context,
                                                  //   title: 'مرحبــاً بعــودتك',
                                                  //   desc:
                                                  //       'تم تسجيل دخولك بنجاح الى التطبيق',
                                                  //   showBtnCancel: false,
                                                  //   btnOkText:
                                                  //       'الذهـاب الى الصفحة الرئيسية',
                                                  //   btnOkOnPress: () {
                                                  //     Get.offAll(Home());
                                                  //   },
                                                  // );
                                                }
                                              },
                                        text: 'تسجيل دخول',
                                        textStyle: MyTextStyles.font14WhiteBold,
                                      );
                              },
                            )),
                            SizedBox(
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
