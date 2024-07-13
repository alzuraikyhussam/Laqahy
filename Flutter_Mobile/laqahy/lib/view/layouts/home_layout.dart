import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/mother_vaccine.dart';
import 'package:laqahy/view/screens/profile.dart';
import 'package:laqahy/view/screens/settings_page.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          alignment: AlignmentDirectional.center,
                          // height: Get.height,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.person_3_outlined,
                            color: MyColors.primaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  sdc.greeting.value,
                                  style: MyTextStyles.font16PrimaryBold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  sdc.userLoggedData.first.motherName ??
                                      'مجهول الهوية',
                                  style: MyTextStyles.font16BlackBold,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: MyColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: MyColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: MyColors.primaryColor,
            ),
            Expanded(
              child: PageView(
                controller: hlc.pageController,
                onPageChanged: (value) {
                  hlc.visit(value);
                },
                children: [
                  Home(),
                  Login(),
                  Profile(),
                  // SettingsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomBarInspiredInside(
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          items: hlc.items,
          backgroundColor: Colors.white,
          color: MyColors.secondaryColor,
          colorSelected: Colors.white,
          indexSelected: hlc.visit.value,
          onTap: (int index) {
            hlc.visit(index);
            hlc.pageController.animateToPage(
              hlc.visit.value,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          elevation: 20,
          chipStyle:
              ChipStyle(convexBridge: true, background: MyColors.primaryColor),
          itemStyle: ItemStyle.circle,
          animated: true,
        );
      }),
    );
  }
}
