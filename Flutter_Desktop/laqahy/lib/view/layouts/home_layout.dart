import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/create_account.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/child_visit_data.dart';
import 'package:laqahy/view/widgets/basic_widgets/home.dart';
import 'package:window_manager/window_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions homeWindowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(homeWindowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.setFullScreen(true);
      await windowManager.setTitle('Laqahy | لقـاحي');
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/home-layout-bg.png',
            ),
          ),
          myCopyRightText(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                height: screenHeight,
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.greyColor.withOpacity(0.2),
                      blurRadius: 20,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/window-logo.png',
                      // width: 100,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              hlc.changeChoose(
                                Constants.homeLayoutItems[index].label,
                              );
                            },
                            child: Obx(
                              () => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: hlc.choose.value == 'تسجيل الخروج'
                                      ? LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                          ],
                                          begin: AlignmentDirectional.topCenter,
                                          end:
                                              AlignmentDirectional.bottomCenter,
                                        )
                                      : hlc.choose.value ==
                                              Constants
                                                  .homeLayoutItems[index].label
                                          ? LinearGradient(
                                              colors: [
                                                MyColors.primaryColor,
                                                MyColors.secondaryColor,
                                              ],
                                              begin: AlignmentDirectional
                                                  .topCenter,
                                              end: AlignmentDirectional
                                                  .bottomCenter,
                                            )
                                          : null,
                                ),
                                child: myHomeLayoutItems(
                                  icon: Icon(
                                    Constants.homeLayoutItems[index].icon,
                                    color: Constants
                                                .homeLayoutItems[index].label ==
                                            'تسجيل الخروج'
                                        ? MyColors.redColor
                                        : hlc.choose.value ==
                                                Constants.homeLayoutItems[index]
                                                    .label
                                            ? MyColors.whiteColor
                                            : MyColors.greyColor,
                                    size: 30,
                                  ),
                                  label: Text(
                                    Constants.homeLayoutItems[index].label,
                                    style: Constants
                                                .homeLayoutItems[index].label ==
                                            'تسجيل الخروج'
                                        ? MyTextStyles.font16RedBold
                                        : hlc.choose.value ==
                                                Constants.homeLayoutItems[index]
                                                    .label
                                            ? MyTextStyles.font16WhiteBold
                                            : MyTextStyles.font16GreyBold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: Constants.homeLayoutItems.length,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(-20, 5),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Expanded(
                              child: Text(
                                hlc.choose.value == 'الرئيسية'
                                    ? 'الصفحـــة الــرئيـسـيـــة'
                                    : 'قـائـمــة ${hlc.choose.value}',
                                style: MyTextStyles.font18PrimaryBold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'صبـاح الخيـر',
                                      style: MyTextStyles.font16PrimaryBold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'شفيع احمد سعيد قائد',
                                      style: MyTextStyles.font16GreyBold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              myHomeLayoutAppBarButtons(
                                icon: Icons.dark_mode_outlined,
                                onTap: () {},
                                gradientColors: [
                                  MyColors.primaryColor,
                                  MyColors.secondaryColor,
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              myHomeLayoutAppBarButtons(
                                icon: Icons.power_settings_new_rounded,
                                onTap: () {},
                                gradientColors: [
                                  MyColors.greyColor,
                                  MyColors.greyColor,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Expanded(
                        child: Obx(
                          () {
                            if (hlc.choose.value == 'الرئيسية') {
                              return HomeScreen();
                            } else {
                              return HomeScreen();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
