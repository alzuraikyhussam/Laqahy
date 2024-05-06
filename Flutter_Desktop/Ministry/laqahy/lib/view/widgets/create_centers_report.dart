import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/reports_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateCentersReportDialog extends StatefulWidget {
  const CreateCentersReportDialog({super.key});

  @override
  State<CreateCentersReportDialog> createState() =>
      _CreateCentersReportDialogState();
}

class _CreateCentersReportDialogState extends State<CreateCentersReportDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 230,
        width: 450,
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
              'تقريـر عــن المـراكـز الصحيــة',
              style: MyTextStyles.font18PrimaryBold,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<ReportsController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 200,
                      hintText: 'المحـافـظـة',
                      items: controller.cities,
                      onChanged: (String? value) {
                        controller.changeCitySelectedValue(value!);
                      },
                      searchController: controller.citySearchController.value,
                      selectedValue: controller.citySelectedValue,
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                GetBuilder<ReportsController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 200,
                      hintText: 'المـديريــة',
                      items: controller.directorates,
                      onChanged: (String? value) {
                        controller.changeDirectorateSelectedValue(value!);
                      },
                      searchController:
                          controller.directorateSearchController.value,
                      selectedValue: controller.directorateSelectedValue,
                    );
                  },
                ),
              ],
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
          text: 'إنشــاء تقـريــر',
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
