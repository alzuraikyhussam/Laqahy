import 'package:get/get.dart';
import 'package:laqahy/models/model.dart';

class HomeController extends GetxController {
  List<HomeCards> homeCardItems=[
    HomeCards(imageName: 'assets/icons/status-count.png', title: 'إجمالي عدد الحالات', value: 1200),
    HomeCards(imageName: 'assets/icons/women-count.png', title: 'إجمالي عدد الأمهات', value: 700),
    HomeCards(imageName: 'assets/icons/children-count.png', title: 'إجمالي عدد الأطفال', value: 500),
    HomeCards(imageName: 'assets/icons/emp-count.png', title: 'إجمالي عدد الموظفين', value: 3),
  ];
}