import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/visit_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/visits/child_visit_data.dart';
import 'package:laqahy/view/widgets/visits/mother_visit_data.dart';

class VisitsLayout extends StatefulWidget {
  const VisitsLayout({super.key});

  @override
  State<VisitsLayout> createState() => _VisitsLayoutState();
}

class _VisitsLayoutState extends State<VisitsLayout> {
  VisitLayoutController vlc = Get.put(VisitLayoutController());

  @override
  void initState() {
    vlc.onChangedTapVisit('m');
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
            'assets/images/visits-image.svg',
            width: 450,
          ),
        ),
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
                  Obx(() {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          vlc.onChangedTapVisit('m');
                        },
                        child: Container(
                          decoration: vlc.visitTapChange.value == 'm'
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
                              style: vlc.visitTapChange.value == 'm'
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
                          vlc.onChangedTapVisit('c');
                        },
                        child: Container(
                          decoration: vlc.visitTapChange.value == 'c'
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
                              style: vlc.visitTapChange.value == 'c'
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
              height: 50,
            ),
            Obx(() {
              return vlc.visitTapChange.value == 'm'
                  ? MotherVisitData()
                  : vlc.visitTapChange.value == 'c'
                      ? ChildVisitData()
                      : SizedBox();
            }),
          ],
        ),
      ],
    );
  }
}
