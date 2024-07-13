import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:laqahy/controllers/child_vaccine_controller.dart';
import 'package:laqahy/controllers/select_child_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ChooseChildAlert extends StatefulWidget {
  const ChooseChildAlert({super.key});

  @override
  State<ChooseChildAlert> createState() => _ChooseChildAlertState();
}

class _ChooseChildAlertState extends State<ChooseChildAlert> {
  SelectChildController csc = Get.put(SelectChildController());
  ChildVaccineController cvc = Get.put(ChildVaccineController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Form(
        key: csc.selectChildFormKey,
        child: SizedBox(
          height: 250,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                myCircleAvatar(icon: Icons.child_care),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'اختاري طفلك',
                    style: MyTextStyles.font18BlackBold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width,
                  child: csc.childrenDropdownMenu(),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Obx(() {
          return cvc.isLoading.value
              ? myLoadingIndicator(width: 120)
              : myButton(
                  onPressed: cvc.isLoading.value
                      ? null
                      : () {
                          if (csc.selectChildFormKey.currentState!.validate()) {
                            cvc.fetchChildVaccineDataTable(
                                csc.selectedChildId.value!);
                          }
                        },
                  width: 120,
                  text: 'مــــوافق',
                  textStyle: MyTextStyles.font16WhiteBold,
                );
        }),
        myButton(
          onPressed: () {
            Get.back();
          },
          text: 'إلـغــاء الأمـــر',
          textStyle: MyTextStyles.font14WhiteBold,
          backgroundColor: MyColors.greyColor,
        ),
      ],
    );
  }
}
