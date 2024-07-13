import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar(
        text: '',
        showBackButton: true,
        onTap: () {
          Get.back();
        },
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'نسيت كلمة المرور',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'قم بإدخال رقم هاتفك  وسوف يتم إرسال كود التأكيد الى هاتفك .',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    labelText: 'أدخل رقم الهاتف ',
                    prefixIcon: Icons.phone_enabled_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myButton(
                    width: width,
                    text: 'إعادة تعيين كلمة المرور',
                    textStyle: MyTextStyles.font14WhiteBold,
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            alignment: AlignmentDirectional.center,
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                myCircleAvatar(icon: Icons.child_care),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'تم الإرسـال بنجـاح',
                                  style: MyTextStyles.font18BlackBold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'لقد تم إرسال كود التحقق الى رقم جوالك.',
                                  style: MyTextStyles.font18BlackBold,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            actions: [
                              myButton(
                                onPressed: () {
                                  Get.off(ResetPasswordVerification());
                                },
                                text: 'مــــوافق',
                                textStyle: MyTextStyles.font14WhiteBold,
                                backgroundColor: MyColors.primaryColor,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
