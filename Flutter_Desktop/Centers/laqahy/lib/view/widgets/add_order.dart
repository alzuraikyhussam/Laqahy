import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/add_order_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/orders_confirmation_successfully.dart';
import 'package:laqahy/view/widgets/success_order.dart';
import 'package:laqahy/view/widgets/successfully_add_order.dart';
import 'package:laqahy/view/widgets/status/successfully_add_state.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  AddOrderController aoc = Get.put(AddOrderController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اســـم اللـقـــاح',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<AddOrderController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 300,
                      hintText: 'اختر اللقــاح',
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
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الـكميــــة',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.numbers,
                  width: 150,
                  hintText: 'حـدد الكـميــة',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملاحــظات',
              style: MyTextStyles.font16BlackBold,
            ),
            SizedBox(
              height: 10,
            ),
            myTextField(
              width: 470,
              maxLines: 3,
              maxLength: 150,
              hintText: 'ملاحظات',
              prefixIcon: Icons.message_outlined,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            myButton(
              onPressed: () {
                myShowDialog(
                    context: context, widgetName: SuccessfullyAddOrder());
              },
              text: 'إضــافــة',
              textStyle: MyTextStyles.font16WhiteBold,
              width: 130,
            ),
            SizedBox(
              width: 15,
            ),
            myButton(
              onPressed: () {
                hlc.changeChoose(
                  'الرئيسية',
                );
              },
              text: 'خـــــروج',
              textStyle: MyTextStyles.font16WhiteBold,
              width: 130,
              backgroundColor: MyColors.greyColor,
            ),
          ],
        ),
      ],
    );
  }
}
