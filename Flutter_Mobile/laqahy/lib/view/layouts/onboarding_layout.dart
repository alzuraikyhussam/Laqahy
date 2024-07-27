import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/onboarding_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login/login.dart';
import 'package:laqahy/view/screens/onboarding_screens/first_onboarding.dart';
import 'package:laqahy/view/screens/onboarding_screens/second_onboarding.dart';
import 'package:laqahy/view/screens/onboarding_screens/third_onboarding.dart';

class OnboardingLayout extends StatefulWidget {
  const OnboardingLayout({super.key});

  @override
  State<OnboardingLayout> createState() => _OnboardingLayoutState();
}

class _OnboardingLayoutState extends State<OnboardingLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  OnboardingController obc = Get.put(OnboardingController());
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/screen-background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(
              () => PageView(
                onPageChanged: (index) {
                  obc.changeIndex(index);
                },
                controller: obc.pageController.value,
                scrollBehavior: const MaterialScrollBehavior(),
                reverse: true,
                children: const [
                  FirstOnboarding(),
                  SecondOnboarding(),
                  ThirdOnboarding(),
                ],
              ),
            ),
          ),
          Positioned(
            // left: 0,
            right: 40,
            bottom: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (obc.currentIndex.value != 2) {
                      obc.pageController.value.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Get.offAll(
                        const LoginScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      );
                      await sdc.storageService.setRegistered(true);
                    }
                  },
                  child: Obx(
                    () => Container(
                      width: obc.currentIndex.value == 2 ? 100 : null,
                      padding: obc.currentIndex.value == 2
                          ? const EdgeInsets.all(12)
                          : const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: obc.currentIndex.value != 2
                          ? Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: MyColors.whiteColor,
                              size: 25,
                            )
                          : Text(
                              'البــدء',
                              style: MyTextStyles.font16WhiteBold,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 40,
            // right: 20,
            bottom: 50,
            child: Row(
              children: [
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  height: 10,
                  width: 150,
                  child: ListView.separated(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Obx(() => Container(
                            height: 8,
                            width: 18,
                            // padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              gradient: obc.currentIndex.value != index
                                  ? LinearGradient(
                                      colors: [
                                        MyColors.primaryColor.withOpacity(0.3),
                                        MyColors.primaryColor.withOpacity(0.3),
                                      ],
                                      begin: AlignmentDirectional.topCenter,
                                      end: AlignmentDirectional.bottomCenter,
                                    )
                                  : LinearGradient(
                                      colors: [
                                        MyColors.primaryColor,
                                        MyColors.primaryColor,
                                      ],
                                      begin: AlignmentDirectional.topCenter,
                                      end: AlignmentDirectional.bottomCenter,
                                    ),
                              boxShadow: [
                                obc.currentIndex.value == index
                                    ? BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.3),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                        spreadRadius: 1,
                                      )
                                    : BoxShadow(
                                        color:
                                            MyColors.greyColor.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: const Offset(0, 0),
                                        spreadRadius: 0,
                                      ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: 3,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
