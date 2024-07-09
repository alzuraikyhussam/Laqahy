import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateOrdersReportDialog extends StatefulWidget {
  const CreateOrdersReportDialog({super.key});

  @override
  State<CreateOrdersReportDialog> createState() =>
      _CreateOrdersReportDialogState();
}

class _CreateOrdersReportDialogState extends State<CreateOrdersReportDialog> {
  ReportController rc = Get.put(ReportController());

  @override
  void initState() {
    rc.fetchMinMaxOrdersDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rc.createOrdersReportFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 300,
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
                  'تقريـر عــن الطبــات',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: rc.centersDropdownMenu(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.vaccinesDropdownMenu(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    rc.orderStateDropdownMenu(),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: rc.dateField(
                        controller: rc.firstDateController,
                        hintText: 'من تاريـخ',
                        validator: rc.firstDateValidator,
                        onPressedRefresh: () {
                          rc.fetchMinMaxOrdersDates();
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
                          rc.fetchMinMaxOrdersDates();
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
            return rc.isGenerateOrdersReportLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: rc.isGenerateOrdersReportLoading.value
                        ? null
                        : () {
                            if (rc.createOrdersReportFormKey.currentState!
                                .validate()) {
                              rc.handleOrdersReportOptions();
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
