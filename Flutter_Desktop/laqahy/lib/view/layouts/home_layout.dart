import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/layouts/orders_layout.dart';
import 'package:laqahy/view/layouts/visits_layout.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/employee.dart';
import 'package:laqahy/view/widgets/home.dart';
import 'package:laqahy/view/widgets/mother_visit_data.dart';
import 'package:laqahy/view/widgets/posts.dart';
import 'package:laqahy/view/widgets/system_info.dart';
import 'package:laqahy/view/widgets/techincal_support.dart';
import 'package:window_manager/window_manager.dart';

import '../widgets/vaccinations_page.dart';
import 'status_layout.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WindowListener {
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

    windowManager.addListener(this);
    _init();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      return await hlc.onTapExitButton(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Obx(() {
            return hlc.choose.value == 'الرئيسية'
                ? Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/home-layout-bg.png',
                    ),
                  )
                : const SizedBox();
          }),
          myCopyRightText(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                height: screenHeight,
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.primaryColor.withOpacity(0.2),
                      blurRadius: 20,
                    ),
                  ],
                  color: Colors.white,
                  border: BorderDirectional(
                    end: BorderSide(
                      color: MyColors.primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/window-logo.png',
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {
                              hlc.changeChoose(
                                Constants.homeLayoutItems[index].label,
                                context: ctx,
                              );
                            },
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: hlc.choose.value == 'تسجيل الخروج'
                                      ? const LinearGradient(
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
                                  image: Image.asset(
                                      Constants.homeLayoutItems[index].label ==
                                              'تسجيل الخروج'
                                          ? Constants
                                              .homeLayoutItems[index].imageName
                                          : hlc.choose.value ==
                                                  Constants
                                                      .homeLayoutItems[index]
                                                      .label
                                              ? Constants.homeLayoutItems[index]
                                                  .imageNameFocused
                                              : Constants.homeLayoutItems[index]
                                                  .imageName),
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
                          return const SizedBox(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.primaryColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(-20, 5),
                          ),
                        ],
                        border: BorderDirectional(
                          bottom: BorderSide(
                            color: MyColors.primaryColor.withOpacity(0.5),
                          ),
                        ),
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
                              const SizedBox(
                                width: 30,
                              ),
                              myIconButton(
                                icon: Icons.dark_mode_outlined,
                                onTap: () {},
                                gradientColors: [
                                  MyColors.primaryColor,
                                  MyColors.secondaryColor,
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              myIconButton(
                                icon: FontAwesomeIcons.minus,
                                onTap: () {
                                  hlc.onTapMinimize();
                                },
                                gradientColors: [
                                  MyColors.greyColor,
                                  MyColors.greyColor,
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              myIconButton(
                                icon: Icons.power_settings_new_rounded,
                                onTap: () {
                                  hlc.onTapExitButton(context);
                                },
                                gradientColors: [
                                  MyColors.redColor,
                                  MyColors.redColor,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: hlc.choose.value == 'الرئيسية'
                            ? EdgeInsets.all(30)
                            : EdgeInsetsDirectional.only(
                                top: 30,
                                bottom: 0,
                                end: 30,
                                start: 30,
                              ),
                        child: Obx(
                          () {
                            if (hlc.choose.value == 'الرئيسية') {
                              return const HomeScreen();
                            } else if (hlc.choose.value == 'الموظفين') {
                              return const EmployeeScreen();
                            } else if (hlc.choose.value == 'الحالات') {
                              return const StatusLayout();
                            } else if (hlc.choose.value == 'الزيارات') {
                              return const VisitsLayout();
                            } else if (hlc.choose.value == 'اللقاحات') {
                              return const VaccinationsPage();
                            } else if (hlc.choose.value == 'الطلبات') {
                              return const OrdersLayout();
                            } else if (hlc.choose.value == 'حول النظام') {
                              return const SystemInfoScreen();
                            } else if (hlc.choose.value == 'الدعم الفني') {
                              return TechnicalSupport();
                            } else {
                              return const SizedBox();
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
