import 'package:get/get.dart';
import 'package:laqahy/models/model.dart';

class HomeController extends GetxController {
  List<HomeCards> homeCardItems = [
    HomeCards(
        imageName: 'assets/icons/building.png',
        title: ' عدد المراكز الصحية',
        value: 1200),
    HomeCards(
        imageName: 'assets/icons/women-count.png',
        title: ' عدد الأمهات',
        value: 700),
    HomeCards(
        imageName: 'assets/icons/children-count.png',
        title: ' عدد الأطفال',
        value: 500),
    HomeCards(
        imageName: 'assets/icons/vaccines-icon.png',
        title: ' عدد اللقاحات',
        value: 4000),
    HomeCards(
        imageName: 'assets/icons/order-icon.png',
        title: ' عدد الطلبات',
        value: 3),
  ];
}
