import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ExitAppConfirmAlert extends StatelessWidget {
  const ExitAppConfirmAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 350,
        width: 300,
        // padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myCircleAvatar(
              icon: Icons.logout_outlined,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: Text(
                'تأكيـــــــــد ',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'هل أنت متأكد من عملية الخروج من التطبيق؟',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // width: 130,
                  child: myButton(
                      backgroundColor: MyColors.primaryColor,
                      onPressed: () {},
                      text: 'نعم خروج',
                      textStyle: MyTextStyles.font16WhiteBold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 0,
                  // width: 130,
                  child: myButton(
                      backgroundColor: MyColors.greyColor,
                      onPressed: () {},
                      text: 'إلغــاء الأمـــر',
                      textStyle: MyTextStyles.font16WhiteBold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
