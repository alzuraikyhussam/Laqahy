import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/view/layouts/orders/orders_layout.dart';
import 'package:laqahy/view/widgets/home/home.dart';
import 'package:laqahy/view/widgets/accounts/accounts.dart';
import 'package:laqahy/view/widgets/posts/posts.dart';
import 'package:laqahy/view/widgets/reports/reports.dart';
import 'package:laqahy/view/widgets/system_info/system_info.dart';
import 'package:laqahy/view/widgets/support/support.dart';
import 'package:laqahy/view/widgets/users/users.dart';
import 'package:laqahy/view/widgets/vaccines/vaccines.dart';

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
            } else if (hlc.choose.value == 'حسابات المراكز') {
              return const AccountsPage();
            } else if (hlc.choose.value == 'اللقاحات') {
              return const VaccinesScreen();
            } else if (hlc.choose.value == 'الطلبات') {
              return const OrdersLayout();
            } else if (hlc.choose.value == 'الإعلانات') {
              return const PostsScreen();
            } else if (hlc.choose.value == 'التقارير') {
              return const ReportsPage();
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
