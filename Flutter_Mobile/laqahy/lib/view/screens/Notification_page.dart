import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'ألاشعارات',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  width: 360,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.greyColor, width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.person_2_outlined,
                          color: MyColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'مرحبا يرجى مراجعه اقرب مركز صحي   ',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          Text(
                            ' لاخذ اللقاح الخاص بك',
                            style: MyTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.redColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.delete_outline,
                          color: MyColors.redColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  width: 360,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.greyColor, width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.child_care,
                          color: MyColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'مرحبا يرجى مراجعه اقرب مركز صحي   ',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          Text(
                            ' لاخذ اللقاح الخاص بطفلك',
                            style: MyTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.redColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.delete_outline,
                          color: MyColors.redColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
