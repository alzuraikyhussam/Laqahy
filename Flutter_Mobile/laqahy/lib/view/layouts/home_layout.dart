import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/home.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/mother_vaccine.dart';
import 'package:laqahy/view/screens/profile.dart';

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
      body: PageView(
        controller: hlc.pageController,
        onPageChanged: (value) {
          hlc.visit(value);
        },
        children: [
          Home(),
          Login(),
          Profile(),
          MotherVaccine(),
        ],
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
