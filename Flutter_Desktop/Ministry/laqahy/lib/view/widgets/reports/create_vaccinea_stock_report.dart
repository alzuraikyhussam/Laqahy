import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateVaccinesStockReportDialog extends StatefulWidget {
  const CreateVaccinesStockReportDialog({super.key});

  @override
  State<CreateVaccinesStockReportDialog> createState() =>
      _CreateVaccinesStockReportDialogState();
}

class _CreateVaccinesStockReportDialogState
    extends State<CreateVaccinesStockReportDialog> {
  ReportController rc = Get.put(ReportController());

  @override
  void initState() {
    rc.fetchMinMaxVaccinesStockDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rc.createVaccinesStockReportFormKey,
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
                  'تقريـر عــن حركــة المخـزون',
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
                      child: rc.vaccinesDropdownMenu(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.donorsDropdownMenu(),
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
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.dateField(
                        hintText: 'الى تاريـخ',
                        controller: rc.lastDateController,
                        validator: rc.lastDateValidator,
                        onPressedRefresh: () {
                          rc.fetchMinMaxVaccinesStockDates();
                          Get.back();
                        },
                      ),
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
            return rc.isGenerateVaccinesStockReportLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: rc.isGenerateVaccinesStockReportLoading.value
                        ? null
                        : () {
                            if (rc
                                .createVaccinesStockReportFormKey.currentState!
                                .validate()) {
                              rc.handleVaccinesStockReportOptions();
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
