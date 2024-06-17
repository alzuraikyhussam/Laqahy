import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/setting_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  SettingController sC = SettingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myCircleAvatar(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'مرحبا بك',
                    style: MyTextStyles.font16WhiteBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'زينب محمد صالح الاشول',
                      style: MyTextStyles.font16WhiteBold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            SingleChildScrollView(
              child: Container(
                width: 395,
                height: 387,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      ...List.generate(
                        sC.items.length,
                        (index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: sC.items[index]['icon'],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      sC.items[index]['label'],
                                      style: MyTextStyles.font14BlackBold,
                                    ),
                                  ],
                                ),
                               Obx(() => sC.items[index]['pericon'],) 
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
