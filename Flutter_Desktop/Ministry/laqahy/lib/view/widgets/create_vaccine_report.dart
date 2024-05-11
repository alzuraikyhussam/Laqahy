import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_vaccine_report_controller.dart';
import 'package:laqahy/controllers/reports_controller.dart';
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
  CreateVaccineReportController cvrc = Get.put(CreateVaccineReportController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cvrc.createVaccineReportFormKey,
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
                  'تقريـر عــن اللقـاحــات',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<CreateVaccineReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 250,
                          validator: cvrc.vaccineTypeValidator,
                          hintText: 'اختر نــوع الـلقـــاح',
                          items: controller.vaccineTypes,
                          onChanged: (String? value) {
                            controller.changeVaccineTypeSelectedValue(value!);
                          },
                          searchController:
                              controller.vaccineTypeSearchController.value,
                          selectedValue: controller.vaccineTypeSelectedValue,
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GetBuilder<CreateVaccineReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 250,
                          validator: cvrc.sourceValidator,
                          hintText: 'اختر الجهـة المـانحــة',
                          items: controller.source,
                          onChanged: (String? value) {
                            controller.changeSourceSelectedValue(value!);
                          },
                          searchController:
                              controller.sourceSearchController.value,
                          selectedValue: controller.sourceSelectedValue,
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
                    myTextField(
                      width: 250,
                      controller: cvrc.beginDateController,
                      validator: cvrc.beginDateValidator,
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
                      controller: cvrc.endDateController,
                      validator: cvrc.endDateValidator,
                      width: 250,
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
              if (cvrc.createVaccineReportFormKey.currentState!.validate()) {}
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
