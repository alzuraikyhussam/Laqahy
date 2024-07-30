import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/select_child_controller.dart';
import 'package:laqahy/models/home_model.dart';
import 'package:laqahy/view/screens/awareness_info/awareness_information.dart';
import 'package:laqahy/view/screens/child_vaccines/choose_children.dart';
import 'package:laqahy/view/screens/mother_vaccines/mother_vaccine.dart';
import 'package:laqahy/view/screens/settings/settings.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeController extends GetxController {
  List<HomeGridViewItem> homeGridViewItems = [
    HomeGridViewItem(
      icon: Icons.child_care_rounded,
      title: 'لقاحات الطفل',
      onTap: () {
        Get.delete<SelectChildController>();
        myShowDialog(
          barrierDismissible: true,
          context: Get.context!,
          widgetName: const ChooseChildAlert(),
        );
      },
    ),
    HomeGridViewItem(
      icon: Icons.woman_2_outlined,
      title: 'لقاحات الأم',
      onTap: () {
        Get.to(() => const MotherVaccine());
      },
    ),
    HomeGridViewItem(
      icon: Icons.medical_information_outlined,
      title: 'معلومات توعوية',
      onTap: () {
        Get.to(() => const AwarenessInfoScreen());
      },
    ),
    HomeGridViewItem(
      icon: Icons.settings_outlined,
      title: 'الإعدادات',
      onTap: () {
        Get.to(() => const SettingsScreen());
      },
    ),
  ];
}
