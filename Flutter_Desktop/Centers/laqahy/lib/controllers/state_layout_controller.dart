import 'package:get/get.dart';

class StateLayoutController extends GetxController {
  RxString stateTapChange = 'm'.obs;

  onChangedTapState(String state) {
    stateTapChange.value = state;
  }
}
