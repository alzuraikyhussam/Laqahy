import 'package:get/get.dart';

class OrdersLayoutController extends GetxController {
  RxString orderChange = 'add'.obs;

  onChangeOrder(String order) {
    orderChange.value = order;
  }
}
