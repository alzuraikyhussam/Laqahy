import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/awareness_information.dart';
import 'package:laqahy/view/screens/children_vaccine.dart';
import 'package:laqahy/view/screens/mother_vaccine.dart';
import 'package:laqahy/view/screens/settings_page.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List items = [
    {
      'icon': Icons.child_care,
      'titel': 'لقاحات الطفل ',
      'onPressed': ChildrenVaccine()
    },
    {
      'icon': Icons.woman_2_outlined,
      'titel': 'لقاحات الام ',
      'onPressed': MotherVaccine()
    },
    {
      'icon': Icons.settings,
      'titel': 'الاعدادات ',
      'onPressed': SettingsScreen()
    },
    {
      'icon': Icons.info_outline_rounded,
      'titel': 'معلومات توعوية ',
      'onPressed': AwarenessInformation()
    },
    {}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          // height: Get.height,
          // width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/home_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () => Get.to(items[i]['onPressed']),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                items[i]['icon'],
                                size: 60,
                                color: MyColors.primaryColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                items[i]['titel'],
                                style: MyTextStyles.font14BlackBold,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.greyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.message_outlined,
                                color: MyColors.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'تواصل بنا',
                                style: MyTextStyles.font16PrimaryBold,
                              ),
                              Text(
                                'خدمة دائمة على مدار 24 ساعة',
                                style: MyTextStyles.font16BlackBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        textDirection: TextDirection.ltr,
                        color: MyColors.greyColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.greyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.info,
                                color: MyColors.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'حول التطبيق',
                                style: MyTextStyles.font16PrimaryBold,
                              ),
                              Text(
                                'معلومات حول التطبيق وخدماته  ',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              //Texst(
                              // 'معلومات هامة حول لقاح السل'
                              //Style: MyTextStyles.font16BlackBold,
                              //)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        textDirection: TextDirection.ltr,
                        color: MyColors.greyColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
