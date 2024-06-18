import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SuccessfullyChangPass extends StatelessWidget {
  const SuccessfullyChangPass({super.key});

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
                'تمت العملية بنجاح',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'تم اعاده تعيين كلمة المرور الخاصة',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'بحسابك بنجاح',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              child: myButton(
                  width: 200,
                  backgroundColor: MyColors.primaryColor,
                  onPressed: () {
                    Get.to(Login);
                  },
                  text: 'تسجيل الدخول',
                  textStyle: MyTextStyles.font16WhiteBold),
            ),
          ],
        ),
      ),
    );
  }
}
