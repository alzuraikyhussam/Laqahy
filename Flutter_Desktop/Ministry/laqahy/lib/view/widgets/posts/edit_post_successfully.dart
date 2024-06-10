import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class EditPostSuccessfully extends StatefulWidget {
  const EditPostSuccessfully({super.key});

  @override
  State<EditPostSuccessfully> createState() => _EditPostSuccessfullyState();
}

class _EditPostSuccessfullyState extends State<EditPostSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 250,
        width: 400,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset("assets/images/successfully_image.png",width: 120,),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'تم التعديل ينجاح ',
                      style: MyTextStyles.font18PrimaryBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      'شكراً لك لقد تم تعديل الإعلان بنجاح !',
                      style: MyTextStyles.font18GreyMedium,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        myButton(
          onPressed: () {
            Get.back();
          },
          width: 150,
          text: 'مــوافــق',
          textStyle: MyTextStyles.font16WhiteBold,
        ),
      ],
    );
  }
}
