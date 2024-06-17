import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SuccessfulSendMessage extends StatelessWidget {
  const SuccessfulSendMessage({super.key});

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
                'نحن سعداء على تواصلك معنا',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'سوف يتم حل المشكلة والرد عليك في',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'أقرب وقت ممكن',
                style: MyTextStyles.font16GreyBold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 160,
              child: myButton(
                  backgroundColor: MyColors.primaryColor,
                  onPressed: () {
                    Get.back();
                  },
                  text: 'موافــق',
                  textStyle: MyTextStyles.font16WhiteBold),
            ),
          ],
        ),
      ),
    );
  }
}
