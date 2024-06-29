import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
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
                            style: MyTextStyles.font14PrimaryBold,
                          ),
                          Text('زينب'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: MyColors.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              endIndent: 10,
              indent: 10,
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
