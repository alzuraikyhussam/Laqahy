import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class MenuSide extends StatefulWidget {
  const MenuSide({super.key});

  @override
  State<MenuSide> createState() => _MenuSideState();
}

class _MenuSideState extends State<MenuSide> {
  HomeLayoutController hlc = Get.find<HomeLayoutController>();
  StaticDataController controller = Get.find<StaticDataController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
                return controller.userLoggedData.first.permissionId == 1
                    ? InkWell(
                        onTap: () {
                          hlc.changeChoose(
                            Constants.adminHomeLayoutItems[index].label,
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
                                      end: AlignmentDirectional.bottomCenter,
                                    )
                                  : hlc.choose.value ==
                                          Constants
                                              .adminHomeLayoutItems[index].label
                                      ? LinearGradient(
                                          colors: [
                                            MyColors.primaryColor,
                                            MyColors.secondaryColor,
                                          ],
                                          begin: AlignmentDirectional.topCenter,
                                          end:
                                              AlignmentDirectional.bottomCenter,
                                        )
                                      : null,
                            ),
                            child: myHomeLayoutItems(
                              image: Image.asset(
                                  Constants.adminHomeLayoutItems[index].label ==
                                          'تسجيل الخروج'
                                      ? Constants
                                          .adminHomeLayoutItems[index].imageName
                                      : hlc.choose.value ==
                                              Constants
                                                  .adminHomeLayoutItems[index]
                                                  .label
                                          ? Constants
                                              .adminHomeLayoutItems[index]
                                              .imageNameFocused
                                          : Constants
                                              .adminHomeLayoutItems[index]
                                              .imageName),
                              label: Text(
                                Constants.adminHomeLayoutItems[index].label,
                                style: Constants.adminHomeLayoutItems[index]
                                            .label ==
                                        'تسجيل الخروج'
                                    ? MyTextStyles.font16RedBold
                                    : hlc.choose.value ==
                                            Constants
                                                .adminHomeLayoutItems[index]
                                                .label
                                        ? MyTextStyles.font16WhiteBold
                                        : MyTextStyles.font16GreyBold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          hlc.changeChoose(
                            Constants.userHomeLayoutItems[index].label,
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
                                      end: AlignmentDirectional.bottomCenter,
                                    )
                                  : hlc.choose.value ==
                                          Constants
                                              .userHomeLayoutItems[index].label
                                      ? LinearGradient(
                                          colors: [
                                            MyColors.primaryColor,
                                            MyColors.secondaryColor,
                                          ],
                                          begin: AlignmentDirectional.topCenter,
                                          end:
                                              AlignmentDirectional.bottomCenter,
                                        )
                                      : null,
                            ),
                            child: myHomeLayoutItems(
                              image: Image.asset(
                                  Constants.userHomeLayoutItems[index].label ==
                                          'تسجيل الخروج'
                                      ? Constants
                                          .userHomeLayoutItems[index].imageName
                                      : hlc.choose.value ==
                                              Constants
                                                  .userHomeLayoutItems[index]
                                                  .label
                                          ? Constants.userHomeLayoutItems[index]
                                              .imageNameFocused
                                          : Constants.userHomeLayoutItems[index]
                                              .imageName),
                              label: Text(
                                Constants.userHomeLayoutItems[index].label,
                                style: Constants
                                            .userHomeLayoutItems[index].label ==
                                        'تسجيل الخروج'
                                    ? MyTextStyles.font16RedBold
                                    : hlc.choose.value ==
                                            Constants.userHomeLayoutItems[index]
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
              itemCount: controller.userLoggedData.first.permissionId == 1
                  ? Constants.adminHomeLayoutItems.length
                  : Constants.userHomeLayoutItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
