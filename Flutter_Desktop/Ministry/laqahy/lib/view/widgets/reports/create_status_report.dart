import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/create_status_report_controller.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateStatusReportDialog extends StatefulWidget {
  const CreateStatusReportDialog({super.key});

  @override
  State<CreateStatusReportDialog> createState() =>
      _CreateStatusReportDialogState();
}

class _CreateStatusReportDialogState extends State<CreateStatusReportDialog> {
  ReportController rc = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rc.createStatusReportFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 300,
          width: 550,
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
                    ],
                  ),
                ),
                Text(
                  'تقريـر عــن الحــالات',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: rc.registeredOfficesDropdownMenu(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.centersDropdownMenu(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    rc.statusTypeDropdownMenu(),
                    SizedBox(
                      width: 15,
                    ),
                    rc.dateField(
                      controller: rc.firstDateController,
                      hintText: 'من تاريـخ',
                      validator: rc.firstDateValidator,
                      onPressedRefresh: () {
                        rc.fetchMinMaxStatusDates();
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    rc.dateField(
                      hintText: 'الى تاريـخ',
                      controller: rc.lastDateController,
                      validator: rc.lastDateValidator,
                      onPressedRefresh: () {
                        rc.fetchMinMaxStatusDates();
                        Get.back();
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
        ),
        actions: [
          Obx(() {
            return rc.isGenerateStatusReportLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: rc.isGenerateStatusReportLoading.value
                        ? null
                        : () {
                            if (rc.createStatusReportFormKey.currentState!
                                .validate()) {
                              rc.handleStatusReportOptions();
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
