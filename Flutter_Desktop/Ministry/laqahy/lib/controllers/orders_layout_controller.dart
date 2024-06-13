import 'package:get/get.dart';

class OrdersLayoutController extends GetxController {
  RxString orderTapChange = 'incoming'.obs;

  onChangeOrder(String order) {
    orderTapChange.value = order;
  }
}
