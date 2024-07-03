import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/view/layouts/states/states_layout.dart';
import 'package:laqahy/view/layouts/visits/visits_layout.dart';
import 'package:laqahy/view/widgets/home/home.dart';
import 'package:laqahy/view/widgets/system_info/system_info.dart';
import 'package:laqahy/view/widgets/support/support.dart';
import 'package:laqahy/view/widgets/users/users.dart';

class HomeBodySide extends StatefulWidget {
  const HomeBodySide({super.key});

  @override
  State<HomeBodySide> createState() => _HomeBodySideState();
}

class _HomeBodySideState extends State<HomeBodySide> {
  HomeLayoutController hlc = Get.find<HomeLayoutController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: hlc.choose.value == 'الرئيسية'
            ? const EdgeInsets.all(30)
            : const EdgeInsetsDirectional.only(
                top: 30,
                bottom: 0,
                end: 30,
                start: 30,
              ),
        child: Obx(
          () {
            if (hlc.choose.value == 'الرئيسية') {
              return const HomeScreen();
            } else if (hlc.choose.value == 'المستخدمين') {
              return const UsersScreen();
            } else if (hlc.choose.value == 'الحالات') {
              return const StatesLayout();
            } else if (hlc.choose.value == 'الزيارات') {
              return const VisitsLayout();
            } else if (hlc.choose.value == 'اللقاحات') {
              return const SizedBox();
            } else if (hlc.choose.value == 'الطلبات') {
              return const SizedBox();
            } else if (hlc.choose.value == 'التقارير') {
              return const SizedBox();
            } else if (hlc.choose.value == 'حول النظام') {
              return const SystemInfoScreen();
            } else if (hlc.choose.value == 'الدعم الفني') {
              return const SupportScreen();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
