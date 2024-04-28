import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SuccessfullyAddOrder extends StatelessWidget {
  const SuccessfullyAddOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 280,
        width: 300,
        // padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/successfully_image.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'تم الأضـــافة بنجاح',
                style: MyTextStyles.font16PrimaryBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                '  لقد تم اضافة الطلب بنجاح ',
                style: MyTextStyles.font14GreyBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 130,
              child: myButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: 'موافق',
                  textStyle: MyTextStyles.font16WhiteBold),
            ),
          ],
        ),
      ),
    );
  }
}
