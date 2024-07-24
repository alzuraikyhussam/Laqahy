import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/settings_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController sc = SettingsController();
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        onTap: () => Get.back(),
        backgroundColor: MyColors.primaryColor,
        iconColor: MyColors.whiteColor,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 5,
                        color: MyColors.secondaryColor,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/profile-image.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    // 'sdc.userLoggedData.first.user.motherName' ??
                    //     'مجهول الهوية',
                    sdc.userLoggedData.first.user.motherName ?? 'مجهول الهوية',
                    style: MyTextStyles.font16WhiteBold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // 'الرقم الوطني:',
                    'الرقم الوطني: ${sdc.userLoggedData.first.user.identityNum}',
                    style: MyTextStyles.font14WhiteMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: mySettingsListView(
                    items: sc.settingsListViewItems,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
