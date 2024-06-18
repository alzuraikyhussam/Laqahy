import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeTopBarSide extends StatefulWidget {
  const HomeTopBarSide({super.key});

  @override
  State<HomeTopBarSide> createState() => _HomeTopBarSideState();
}

class _HomeTopBarSideState extends State<HomeTopBarSide> {
  HomeLayoutController hlc = Get.find<HomeLayoutController>();
  StaticDataController controller = Get.find<StaticDataController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () {
              return hlc.choose.value == 'الرئيسية'
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          hlc.choose.value == 'الرئيسية'
                              ? Expanded(
                                  child: Text(
                                    'مرحبــاً بكــم في',
                                    style: MyTextStyles.font16GreyBold,
                                  ),
                                )
                              : const SizedBox(),
                          Expanded(
                            child: Text(
                              controller.centerData.first.name,
                              style: MyTextStyles.font18PrimaryBold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      hlc.choose.value == 'الرئيسية'
                          ? 'الصفحــة الرئيـسيــة'
                          : 'قـائـمــة ${hlc.choose.value}',
                      style: MyTextStyles.font18PrimaryBold,
                    );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => Text(
                        controller.greeting.value,
                        style: MyTextStyles.font16PrimaryBold,
                      )),
                  Text(
                    controller.userLoggedData.first.userName!,
                    style: MyTextStyles.font16GreyBold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
    );
  }
}
