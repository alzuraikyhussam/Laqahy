import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SuccessfullyLogin extends StatelessWidget {
  const SuccessfullyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 350,
        width: 300,
        // padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myCircleAvatar(),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: Text(
                'مرحبا بعودتك',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'تم تسجيل دخولك بنجاح الى التطبيق',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              child: myButton(
                  width: 250,
                  backgroundColor: MyColors.primaryColor,
                  onPressed: () {
                    Get.to(HomeScreen());
                  },
                  text: 'الذهاب الى الصفحة الرئيسية ',
                  textStyle: MyTextStyles.font16WhiteBold),
            ),
          ],
        ),
      ),
    );
  }
}
