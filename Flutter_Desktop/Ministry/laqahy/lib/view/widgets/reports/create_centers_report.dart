import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_centers_report_controller.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
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
  ReportController rc = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rc.createCentersReportFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 230,
          width: 350,
          child: SingleChildScrollView(
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
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  child: rc.registeredOfficesDropdownMenu(),
                )
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return rc.isGenerateCentersReportLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: rc.isGenerateCentersReportLoading.value
                        ? null
                        : () {
                            if (rc.createCentersReportFormKey.currentState!
                                .validate()) {
                              rc.fetchCentersReport();
                            }
                          },
                    width: 150,
                    text: 'إنشــاء تقـريــر',
                    textStyle: MyTextStyles.font16WhiteBold,
                  );
          }),
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
      ),
    );
  }
}
