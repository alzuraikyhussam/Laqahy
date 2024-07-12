import 'package:get/get.dart';

class VisitLayoutController extends GetxController {
  RxString visitChange = 'm'.obs;

  onChangeVisit(String visit) {
    visitChange.value = visit;
  }
}
