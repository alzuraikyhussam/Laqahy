import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

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
            myCircleAvatar(
                icon: Icons.logout_outlined,
                backgroundColor: MyColors.redColor,
                iconColor: MyColors.redColor),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: Text(
                'هل أنت متأكد من عمليه ',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'تسجيل الخروج من حسابك؟',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              child: myButton(
                  width: 200,
                  backgroundColor: MyColors.redColor,
                  onPressed: () {},
                  text: 'تسجيل الخروج',
                  textStyle: MyTextStyles.font16WhiteBold),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 0,
              // width: 130,
              child: myTextButton(
                text: 'الغاء الامر',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
