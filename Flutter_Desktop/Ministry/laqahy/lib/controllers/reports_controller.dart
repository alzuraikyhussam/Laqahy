import 'package:get/get.dart';
import 'package:laqahy/models/model.dart';

class ReportsController extends GetxController {
  List<ReportsData> reportsCardItems = [
    ReportsData(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن الحالات',
    ),
    ReportsData(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن المراكز الصحية',
    ),
    ReportsData(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن اللقاحات',
    ),
    ReportsData(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن الطلبات',
    ),
  ];
}
