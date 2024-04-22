import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class VaccinationsPage extends StatefulWidget {
  const VaccinationsPage({super.key});

  @override
  State<VaccinationsPage> createState() => _VaccinationsPageState();
}

class _VaccinationsPageState extends State<VaccinationsPage> {
  bool isChecked = false;

  MotherVisitController mvc = Get.put(MotherVisitController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: SvgPicture.asset(
            'assets/images/vaccinations_image.svg',
            width: 450,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myButton(
              onPressed: () {},
              text: 'إضــافــة جــرحــة جــديــدة',
              textStyle: MyTextStyles.font16WhiteBold,
              width: 200,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نــوع اللــقــاح',
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<MotherVisitController>(
                  builder: (controller) {
                    return myDropDownMenuButton(
                      width: 250,
                      hintText: 'إختــر نــوع اللــقــاح',
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
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اســم الــجرعــة الــجــديــدة',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myTextField(
                      prefixIcon: Icons.vaccines,
                      width: 250,
                      hintText: ' أدخل رقم الهاتف',
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onChanged: (value) {},
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
                  onPressed: () {
                    hlc.changeChoose(
                      'الرئيسية',
                    );
                  },
                  text: 'خــروج',
                  textStyle: MyTextStyles.font16WhiteBold,
                  width: 130,
                  backgroundColor: MyColors.greyColor,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
