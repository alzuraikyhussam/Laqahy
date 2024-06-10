import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/reports/create_centers_report.dart';
import 'package:laqahy/view/widgets/reports/create_orders_report.dart';
import 'package:laqahy/view/widgets/reports/create_status_report.dart';
import 'package:laqahy/view/widgets/reports/create_vaccine_report.dart';

class ReportsController extends GetxController {
  List<ReportsData> reportsCardItems = [
    ReportsData(
      imageName: 'assets/icons/status-icon.png',
      title: 'تقرير عن الحالات',
      onPressed: CreateStatusReportDialog(),
    ),
    ReportsData(
      imageName: 'assets/icons/centers-icon.png',
      title: 'تقرير عن المراكز الصحية',
      onPressed: CreateCentersReportDialog(),
    ),
    ReportsData(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن اللقاحات',
      onPressed: CreateVaccineReportDialog(),
    ),
    ReportsData(
      imageName: 'assets/icons/orders-icon.png',
      title: 'تقرير عن الطلبات',
      onPressed: CreateOrdersReportDialog(),
    ),
  ];
}
