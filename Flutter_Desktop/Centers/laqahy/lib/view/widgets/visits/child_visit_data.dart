import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_visit_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/constants/constants.dart';

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
    return Form(
      key: cvc.createChildStatementDataFormKey,
      child: Column(
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
                  const SizedBox(
                    height: 3,
                  ),
                  Constants().mothersDropdownMenu(),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اســـم الطـفــل',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Constants().childsDropdownMenu(),
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
                  const SizedBox(
                    height: 3,
                  ),
                  Constants().visitTypeDropdownMenu(),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نـــوع الـلقـــاح',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Constants().vaccineWithVisitDropdownMenu(),
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
              const SizedBox(
                height: 3,
              ),
              Constants().dosageWithVaccineDropdownMenu(),
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
      ),
    );
  }
}
