import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class MotherVisitData extends StatefulWidget {
  const MotherVisitData({super.key});

  @override
  State<MotherVisitData> createState() => _MotherVisitDataState();
}

class _MotherVisitDataState extends State<MotherVisitData> {
  bool isChecked = false;

  MotherVisitController mvc = Get.put(MotherVisitController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.greyColor.withOpacity(0.1)),
              ),
              width: 450,
              height: 60,
              padding: EdgeInsetsDirectional.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.secondaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'بيانات الأم',
                          style: MyTextStyles.font16WhiteBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'بيانات الطفــل',
                          style: MyTextStyles.font16SecondaryBold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الاســم',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    myTextField(
                      prefixIcon: Icons.woman,
                      width: 300,
                      hintText: 'اســم الحــالة',
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
                      'مرحلــة الـجرعــة',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<MotherVisitController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          width: 280,
                          hintText: 'اختر مرحـلة الجــرعة',
                          items: controller.dosageLevels,
                          onChanged: (String? value) {
                            controller.changeDosageLevelSelectedValue(value!);
                          },
                          searchController:
                              controller.dosageLevelSearchController.value,
                          selectedValue: controller.dosageLevelSelectedValue,
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
                SizedBox(
                  width: 15,
                ),
                myButton(
                  onPressed: () {},
                  text: 'خـــــروج',
                  textStyle: MyTextStyles.font16WhiteBold,
                  width: 130,
                  backgroundColor: MyColors.greyColor,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
