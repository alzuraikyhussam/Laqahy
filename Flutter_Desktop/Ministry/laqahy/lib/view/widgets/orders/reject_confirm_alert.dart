import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class RejectConfirmAlert extends StatefulWidget {
  const RejectConfirmAlert({super.key});

  @override
  State<RejectConfirmAlert> createState() => _RejectConfirmAlertState();
}

class _RejectConfirmAlertState extends State<RejectConfirmAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 320,
        width: 380,
        child: Column(
          children: [
            Container(
              width: 250,
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/window-logo.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'هل انت متاكد من عملية   ',
                      style: MyTextStyles.font16RedBold,
                    ),
                  ),
                  Container(
                    child: Text(
                      'رفض الطلب؟',
                      style: MyTextStyles.font16RedBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                    width: 350,
                    maxLines: 3,
                    maxLength: 150,
                    hintText: 'سبب الرفض',
                    prefixIcon: Icons.message_outlined,
                    keyboardType: TextInputType.text,
                    onChanged: (string) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myButton(
                          onPressed: () {
                            Get.back();
                          },
                          text: 'رفض',
                          textStyle: MyTextStyles.font14WhiteBold,
                          width: 150,
                          backgroundColor: MyColors.redColor),
                      SizedBox(
                        width: 20,
                      ),
                      myButton(
                          onPressed: () {
                            Get.back();
                          },
                          text: 'الغاء الامر',
                          textStyle: MyTextStyles.font14WhiteBold,
                          width: 150,
                          backgroundColor: MyColors.greyColor),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
