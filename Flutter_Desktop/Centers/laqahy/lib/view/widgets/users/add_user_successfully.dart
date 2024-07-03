import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddUserSuccessfully extends StatefulWidget {
  const AddUserSuccessfully({super.key});

  @override
  State<AddUserSuccessfully> createState() => _AddUserSuccessfullyState();
}

class _AddUserSuccessfullyState extends State<AddUserSuccessfully> {
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
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/successfully_image.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'تمت الإضافة بنجاح ',
                      style: MyTextStyles.font16PrimaryBold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'لقد تمت إضافة المستخدم الجديد بنجاح',
                      style: MyTextStyles.font16GreyMedium,
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
