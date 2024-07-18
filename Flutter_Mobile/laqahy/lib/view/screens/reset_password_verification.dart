import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login/login.dart';
import 'package:laqahy/view/screens/reset_password.dart';

import '../../core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ResetPasswordVerification extends StatefulWidget {
  ResetPasswordVerification({super.key});

  int motherId = Get.arguments;

  @override
  State<ResetPasswordVerification> createState() =>
      _ResetPasswordVerificationState();
}

class _ResetPasswordVerificationState extends State<ResetPasswordVerification> {
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ادخلي كود التحقق',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ادخلي كود التحقق الذي ارسلناه اليك على هذا الرقم',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    labelText: 'ادخل كود التحقق',
                    prefixIcon: Icons.credit_card,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  myButton(
                    onPressed: () {
                      Get.off(LoginScreen());
                    },
                    width: width,
                    text: 'التحقق',
                    textStyle: MyTextStyles.font14WhiteBold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: myTextButton(
                      text: 'اعاده ارسال الكود؟',
                      onPressed: () {},
                    ),
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
