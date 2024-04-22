import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ChildStatusData extends StatefulWidget {
  const ChildStatusData({super.key});

  @override
  State<ChildStatusData> createState() => _ChildStatusDataState();
}

class _ChildStatusDataState extends State<ChildStatusData> {
  bool isChecked = false;

  MotherVisitController mvc = Get.put(MotherVisitController());
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
                  'الاســم',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<MotherVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 300,
                      hintText: 'اســم الام',
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
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اســم الــطفــل',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.child_care,
                  width: 300,
                  hintText: 'اســم الــطفــل',
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
                  'مـحـل الـميـلاد',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.place_outlined,
                  width: 200,
                  hintText: 'مـكـان الـميـلاد',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تـاريـخ الميلاد',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  prefixIcon: Icons.date_range_outlined,
                  width: 200,
                  hintText: 'أدخل تاريخ الميلاد',
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الـجـنـس',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<MotherVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 150,
                      hintText: 'نـوع الـجنـس',
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
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الـمـحافـظة',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<MotherVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 170,
                      hintText: 'اسم المحافظة',
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
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الـمـديريـة',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<MotherVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 170,
                      hintText: 'اسم الـمـديرية',
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
              onPressed: () {
                hlc.changeChoose(
                  'الرئيسية',
                );
              },
              text: 'إلــغــاءالأمــر',
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
