import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class FingerPrintCheck extends StatelessWidget {
  const FingerPrintCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 250,
        width: 300,
        // padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myCircleAvatar(
              icon: Icons.fingerprint,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'قومي بوضع أصبعك على',
                style: MyTextStyles.font16BlackBold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                'مستشعر البصمة',
                style: MyTextStyles.font16BlackBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
