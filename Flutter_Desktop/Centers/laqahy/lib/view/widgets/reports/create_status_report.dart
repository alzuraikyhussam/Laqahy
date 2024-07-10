import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
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
  void initState() {
    rc.fetchMinMaxStatusDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rc.createStatusReportFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 230,
          width: 550,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: rc.statusTypeDropdownMenu(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.dateField(
                        controller: rc.firstDateController,
                        hintText: 'من تاريـخ',
                        validator: rc.firstDateValidator,
                        onPressedRefresh: () {
                          rc.fetchMinMaxStatusDates();
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.dateField(
                        hintText: 'الى تاريـخ',
                        controller: rc.lastDateController,
                        validator: rc.lastDateValidator,
                        onPressedRefresh: () {
                          rc.fetchMinMaxStatusDates();
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return rc.isGenerateStatusReportLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: rc.isGenerateStatusReportLoading.value
                        ? null
                        : () {
                            if (rc.createStatusReportFormKey.currentState!
                                .validate()) {
                              rc.fetchStatusReport();
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
