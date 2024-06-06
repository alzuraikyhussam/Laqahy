import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/view/layouts/orders_layout.dart';
import 'package:laqahy/view/widgets/home.dart';
import 'package:laqahy/view/widgets/offices_screen.dart';
import 'package:laqahy/view/widgets/posts.dart';
import 'package:laqahy/view/widgets/reports.dart';
import 'package:laqahy/view/widgets/system_info.dart';
import 'package:laqahy/view/widgets/techincal_support.dart';
import 'package:laqahy/view/widgets/users.dart';
import 'package:laqahy/view/widgets/vaccines_page.dart';

class BodySide extends StatefulWidget {
  const BodySide({super.key});

  @override
  State<BodySide> createState() => _BodySideState();
}

class _BodySideState extends State<BodySide> {
  HomeLayoutController hlc = Get.find<HomeLayoutController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
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
            } else if (hlc.choose.value == 'المكاتب') {
              return const OfficesScreen();
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
              return const TechnicalSupport();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
