import 'package:get/get.dart';

class VisitsLayoutController extends GetxController {
  RxString visitChange = 'm'.obs;

  onChangeVisit(String visit) {
    visitChange.value = visit;
  }
}
