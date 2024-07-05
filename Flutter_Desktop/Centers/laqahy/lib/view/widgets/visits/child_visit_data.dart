import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_visit_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ChildVisitData extends StatefulWidget {
  const ChildVisitData({super.key});

  @override
  State<ChildVisitData> createState() => _ChildVisitDataState();
}

class _ChildVisitDataState extends State<ChildVisitData> {
  bool isChecked = false;
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  ChildVisitController cvc = Get.put(ChildVisitController());

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
                  'اســـم الأم',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.woman_2_outlined,
                  width: 300,
                  hintText: 'اســم الأم',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onChanged: (value) {},
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
                  'اســـم الطـفــل',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.child_care_outlined,
                  width: 300,
                  hintText: 'اســم الطـفــل',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فــترة الـزيـــارة',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<ChildVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 300,
                      hintText: 'اختـر فـترة الــزيـــارة',
                      items: controller.visitTypes,
                      onChanged: (String? value) {
                        controller.changeVisitTypeSelectedValue(value!);
                      },
                      searchController:
                          controller.visitTypeSearchController.value,
                      selectedValue: controller.visitTypeSelectedValue,
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
                  'نـــوع الـلقـــاح',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<ChildVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 300,
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
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'نـــوع الـجرعــة',
              style: MyTextStyles.font16PrimaryBold,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                myCheckBox(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  onChanged: (selected) {
                    setState(() {
                      isChecked = selected;
                    });
                  },
                  value: isChecked,
                  text: 'الأولى',
                ),
                myCheckBox(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  onChanged: (selected) {
                    setState(() {
                      isChecked = selected;
                    });
                  },
                  value: isChecked,
                  text: 'الثانية',
                ),
                myCheckBox(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  onChanged: (selected) {
                    setState(() {
                      isChecked = selected;
                    });
                  },
                  value: isChecked,
                  text: 'الثالثة',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            myButton(
              onPressed: () {},
              text: 'إضــافــة',
              textStyle: MyTextStyles.font16WhiteBold,
              width: 130,
            ),
            // SizedBox(
            //   width: 15,
            // ),
            // myButton(
            //   onPressed: () {
            //     hlc.changeChoose(
            //       'الرئيسية',
            //     );
            //   },
            //   text: 'خـــــروج',
            //   textStyle: MyTextStyles.font16WhiteBold,
            //   width: 130,
            //   backgroundColor: MyColors.greyColor,
            // ),
          ],
        ),
      ],
    );
  }
}
