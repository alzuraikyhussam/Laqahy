import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/add_order_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  AddOrderController aoc = Get.put(AddOrderController());

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
              keyboardType: TextInputType.text,
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }
}
