import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ChooseChild extends StatelessWidget {
  const ChooseChild({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 300,
        width: 340,
        // padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myCircleAvatar(icon: Icons.child_care),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'اختاري طفلك',
                style: MyTextStyles.font18BlackBold,
              ),
            ),
            Expanded(
              child: myDropDownMenuButton(
                  hintText: 'hintText',
                  items: [],
                  onChanged: (s) {},
                  searchController: null,
                  selectedValue: '1'),
            ),
            const SizedBox(
              height: 5,
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
