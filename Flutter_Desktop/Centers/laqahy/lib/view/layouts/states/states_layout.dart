import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/state_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/status/child_status/child_status.dart';
import 'package:laqahy/view/widgets/status/mother_status/mothers_status.dart';

class StatesLayout extends StatefulWidget {
  const StatesLayout({super.key});

  @override
  State<StatesLayout> createState() => _StatesLayoutState();
}

class _StatesLayoutState extends State<StatesLayout> {
  StateLayoutController slc = Get.put(StateLayoutController());
  MotherStatusDataController msc = Get.put(MotherStatusDataController());
  ChildStatusDataController csc = Get.put(ChildStatusDataController());

  @override
  void initState() {
    slc.onChangedTapState('m');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: SvgPicture.asset(
            'assets/images/status_image.svg',
            width: 450,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: MyColors.greyColor.withOpacity(0.1)),
                ),
                width: 450,
                height: 60,
                padding: const EdgeInsetsDirectional.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            slc.onChangedTapState('m');
                            msc.fetchAllMothersStatusData(msc.centerId!);
                          },
                          child: Container(
                            decoration: slc.stateTapChange.value == 'm'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'بيانات الأم',
                                style: slc.stateTapChange.value == 'm'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            slc.onChangedTapState('c');
                            csc.fetchAllChildrenStatusData();
                          },
                          child: Container(
                            decoration: slc.stateTapChange.value == 'c'
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                'بيانات الطفــل',
                                style: slc.stateTapChange.value == 'c'
                                    ? MyTextStyles.font16WhiteBold
                                    : MyTextStyles.font16SecondaryBold,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return slc.stateTapChange.value == 'm'
                    ? const MotherStatusScreen()
                    : slc.stateTapChange.value == 'c'
                        ? const ChildStatusScreen()
                        : const SizedBox();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
