import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_status_report_controller.dart';
import 'package:laqahy/controllers/reports_controller.dart';
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
  CreateStatusReportController csrc = Get.put(CreateStatusReportController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: csrc.createStatusReportFormKey,
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
                    GetBuilder<CreateStatusReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          validator: csrc.cityValidator,
                          width: 220,
                          hintText: 'المحـافظـة',
                          items: controller.cities,
                          onChanged: (String? value) {
                            controller.changeCitySelectedValue(value!);
                          },
                          searchController:
                              controller.citySearchController.value,
                          selectedValue: controller.citySelectedValue,
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GetBuilder<CreateStatusReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 280,
                          validator: csrc.centerNameValidator,
                          hintText: 'المـركـز الصـحـي',
                          items: controller.centers,
                          onChanged: (String? value) {
                            controller.changeCenterSelectedValue(value!);
                          },
                          searchController:
                              controller.centerSearchController.value,
                          selectedValue: controller.centerSelectedValue,
                        );
                      },
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
                    GetBuilder<CreateStatusReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          validator: csrc.statusTypeValidator,
                          width: 165,
                          hintText: 'نـوع الحــالة',
                          items: controller.statusType,
                          onChanged: (String? value) {
                            controller.changeStatusTypeSelectedValue(value!);
                          },
                          searchController:
                              controller.statusTypeSearchController.value,
                          selectedValue: controller.statusTypeSelectedValue,
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    myTextField(
                      width: 160,
                      controller: csrc.beginDateController,
                      validator: csrc.beginDateValidator,
                      prefixIcon: Icons.date_range_outlined,
                      readOnly: true,
                      hintText: 'من تاريـخ',
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    myTextField(
                      width: 160,
                      controller: csrc.endDateController,
                      validator: csrc.endDateValidator,
                      prefixIcon: Icons.date_range_outlined,
                      readOnly: true,
                      hintText: 'الى تاريـخ',
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {},
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
          myButton(
            onPressed: () {
              if (csrc.createStatusReportFormKey.currentState!.validate()) {}
            },
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
      ),
    );
  }
}
