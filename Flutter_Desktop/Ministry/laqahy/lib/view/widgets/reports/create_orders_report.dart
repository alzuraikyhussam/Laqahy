import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/create_orders_report_controller.dart';
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
  CreateOrdersReportController corc = Get.put(CreateOrdersReportController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: corc.createOrdersReportFormKey,
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
                  'تقريـر عــن الطلبــات',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<CreateOrdersReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 220,
                          validator: corc.cityValidator,
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
                    GetBuilder<CreateOrdersReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 280,
                          validator: corc.centerNameValidator,
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
                    GetBuilder<CreateOrdersReportController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 165,
                          validator: corc.orderStatusValidator,
                          hintText: 'حـالـة الطلـب',
                          items: controller.orderStatus,
                          onChanged: (String? value) {
                            controller.changeOrderStatusSelectedValue(value!);
                          },
                          searchController:
                              controller.orderStatusSearchController.value,
                          selectedValue: controller.orderStatusSelectedValue,
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    myTextField(
                      width: 160,
                      controller: corc.beginDateController,
                      validator: corc.beginDateValidator,
                      prefixIcon: Icons.date_range_outlined,
                      readOnly: true,
                      hintText: 'من تاريـخ',
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {},
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime.now())
                            .then(
                          (value) {
                            if (value == null) {
                              return;
                            } else {
                              corc.beginDateController.text =
                                  DateFormat.yMMMd().format(value);
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    myTextField(
                      width: 160,
                      controller: corc.endDateController,
                      validator: corc.endDateValidator,
                      prefixIcon: Icons.date_range_outlined,
                      readOnly: true,
                      hintText: 'الى تاريـخ',
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {},
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime.now())
                            .then(
                          (value) {
                            if (value == null) {
                              return;
                            } else {
                              corc.endDateController.text =
                                  DateFormat.yMMMd().format(value);
                            }
                          },
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
        ),
        actions: [
          myButton(
            onPressed: () {
              if (corc.createOrdersReportFormKey.currentState!.validate()) {}
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
