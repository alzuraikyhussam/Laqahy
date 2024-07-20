import 'package:get/get.dart';

class VisitLayoutController extends GetxController {
  RxString visitTapChange = 'm'.obs;

  onChangedTapVisit(String state) {
    visitTapChange.value = state;
  }
}
