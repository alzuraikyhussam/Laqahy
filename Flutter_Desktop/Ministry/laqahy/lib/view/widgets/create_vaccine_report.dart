import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateVaccineReportDialog extends StatefulWidget {
  const CreateVaccineReportDialog({super.key});

  @override
  State<CreateVaccineReportDialog> createState() =>
      _CreateVaccineReportDialogState();
}

class _CreateVaccineReportDialogState extends State<CreateVaccineReportDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 300,
        width: 350,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myAppBarLogo(
                    width: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Text(
              'تقريـر عــن الحـــالات',
              style: MyTextStyles.font18PrimaryBold,
            ),
            SizedBox(
              height: 20,
            ),
            myTextField(
              width: 300,
              prefixIcon: Icons.source_outlined,
              obscureText: true,
              hintText: 'الجهة المانحة',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.center,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 10,
            ),
            myTextField(
              width: 300,
              prefixIcon: Icons.numbers,
              obscureText: true,
              // suffixIcon: Icons.visibility_off_outlined,
              hintText: 'الكميـة',
              keyboardType: TextInputType.number,
              // textAlign: TextAlign.center,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      actions: [
        myButton(
          onPressed: () {},
          width: 150,
          text: 'مـوافــق',
          textStyle: MyTextStyles.font16WhiteBold,
        ),
        myButton(
          width: 150,
          onPressed: () {
            Get.back();
          },
          text: 'إلـغــاء الأمـــر',
          textStyle: MyTextStyles.font16WhiteBold,
          backgroundColor: MyColors.greyColor,
        ),
      ],
    );
  }
}
