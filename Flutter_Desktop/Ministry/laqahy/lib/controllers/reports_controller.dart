import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/create_centers_report.dart';
import 'package:laqahy/view/widgets/create_orders_report.dart';
import 'package:laqahy/view/widgets/create_status_report.dart';
import 'package:laqahy/view/widgets/create_vaccine_report.dart';

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

  String? vaccineTypeSelectedValue;
  final Rx<TextEditingController> vaccineTypeSearchController =
      TextEditingController().obs;
  final List<String> vaccineTypes = [
    'السل',
    'الخماسي',
  ];
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    vaccineTypeSearchController.close();
    citySearchController.close();
    centerSearchController.close();
    orderStatusSearchController.close();
    statusSearchController.close();
    directorateSearchController.close();
  }

  changeVaccineTypeSelectedValue(String selectedValue) {
    vaccineTypeSelectedValue = selectedValue;
    update();
  }

  String? citySelectedValue;
  String? orderStatusSelectedValue;
  String? centerSelectedValue;
  String? statusSelectedValue;
  String? directorateSelectedValue;
  final Rx<TextEditingController> citySearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> centerSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> statusSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> orderStatusSearchController =
      TextEditingController().obs;
  final Rx<TextEditingController> directorateSearchController =
      TextEditingController().obs;
  final List<String> cities = [
    'تعز',
    'عدن',
  ];
  final List<String> directorates = [
    'المظفر',
    'القاهرة',
  ];
  final List<String> centers = [
    'مركز المظفر',
    'مركز التعاون',
  ];
  final List<String> status = [
    'الأمهــات',
    'الأطـفــال',
  ];
  final List<String> orderStatus = [
    'الواردة',
    'تم التسليم',
    'قيد التسليم',
    'الملغية',
  ];

  changeCitySelectedValue(String selectedValue) {
    citySelectedValue = selectedValue;
    update();
  }

  changeCenterSelectedValue(String selectedValue) {
    centerSelectedValue = selectedValue;
    update();
  }

  changeStatusSelectedValue(String selectedValue) {
    statusSelectedValue = selectedValue;
    update();
  }

  changeOrderStatusSelectedValue(String selectedValue) {
    orderStatusSelectedValue = selectedValue;
    update();
  }

  changeDirectorateSelectedValue(String selectedValue) {
    directorateSelectedValue = selectedValue;
    update();
  }
}
