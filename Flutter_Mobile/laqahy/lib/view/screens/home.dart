import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List items = [
    {'icon': Icons.child_care, 'titel': 'لقاحات الطفل '},
    {'icon': Icons.woman_2_outlined, 'titel': 'لقاحات الام '},
    {'icon': Icons.settings, 'titel': 'الاعدادات '},
    {'icon': Icons.info_outline_rounded, 'titel': 'معلومات توعوية '},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/app-icon.png',
                            width: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'صباح الخير',
                              style: MyTextStyles.font16PrimaryBold,
                            ),
                            Text(
                              'زينب محمد صالح الاشول',
                              style: MyTextStyles.font16BlackBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          child: myIconButton(
                            onPressed: () {},
                            icon: Icons.notifications_none,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          child: myIconButton(
                            onPressed: () {},
                            icon: Icons.dark_mode_outlined,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 350,
                height: 200,
                child: Image.asset('assets/images/home_image.png', ),
              ),
              GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 40),
                itemCount: 4,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          items[i]['icon'],
                          size: 60,
                          color: MyColors.brownColor,
                        ),
                        Text(
                          items[i]['titel'],
                          style: MyTextStyles.font14BlackBold,
                        ),
                      ],
                    ),
                  );
                },
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
    );
  }
}
