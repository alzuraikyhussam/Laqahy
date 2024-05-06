import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class DeletePostConfirm extends StatelessWidget {
  const DeletePostConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
      height: 370,
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
              style: MyTextStyles.font18BlackBold,
            ),
          ),
          Container(
            child: Text(
              'هذا المنشور؟',
              style: MyTextStyles.font18BlackBold,
            ),
          ),
          const SizedBox(
            height: 30,
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
                      onPressed: () {
                        Get.back();
                      },
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
