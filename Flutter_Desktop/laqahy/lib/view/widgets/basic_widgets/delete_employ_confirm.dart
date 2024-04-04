import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class DeleteEmployConfirm extends StatelessWidget {
  const DeleteEmployConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Expanded(
              child: Image.asset(
                "assets/images/confirm_image.png",
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              ' هل أنت متأكد من عملية حذف',
              style: MyTextStyles.font16BlackBold,
            ),
          ),
          Container(
            child: Text(
              'هذاالموظف؟',
              style: MyTextStyles.font16BlackBold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: myButton(
                      backgroundColor: MyColors.redColor,
                      onPressed: () {},
                      text: 'حذف',
                      textStyle: MyTextStyles.font16WhiteBold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 150,
                  child: myButton(
                      backgroundColor: MyColors.greyColor,
                      onPressed: () {},
                      text: 'الغـــاء الأمـــر',
                      textStyle: MyTextStyles.font16WhiteBold),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
