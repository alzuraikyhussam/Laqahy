import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ApprovalOrderAlert extends StatefulWidget {
  const ApprovalOrderAlert({super.key});

  @override
  State<ApprovalOrderAlert> createState() => _ApprovalOrderAlertState();
}

class _ApprovalOrderAlertState extends State<ApprovalOrderAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 350,
        width: 380,
        child: Column(
          children: [
            Container(
              width: 250,
              height: 40,
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
                      'الموافقة على الطلب',
                      style: MyTextStyles.font16PrimaryBold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    width: 350,
                    hintText: 'تحديد الكمية',
                    prefixIcon: Icons.numbers,
                    keyboardType: TextInputType.text,
                    onChanged: (string) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    width: 350,
                    hintText: 'ملاحظة',
                    maxLines: 2,
                    prefixIcon: Icons.message_outlined,
                    keyboardType: TextInputType.text,
                    onChanged: (string) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myButton(
                          onPressed: () {
                            Get.back();
                          },
                          text: 'موافق',
                          textStyle: MyTextStyles.font14WhiteBold,
                          width: 150,
                          backgroundColor: MyColors.primaryColor),
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
