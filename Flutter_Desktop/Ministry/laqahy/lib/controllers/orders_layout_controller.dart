import 'package:get/get.dart';

class OrdersLayoutController extends GetxController {
  RxString orderChange = 'export'.obs;

  onChangeOrder(String order) {
    orderChange.value = order;
  }
}
