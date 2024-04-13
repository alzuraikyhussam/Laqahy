import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  RxString choose = 'الرئيسية'.obs;

  changeChoose(String label) {
    if (label == 'تسجيل الخروج') {
      print('logout');
      return;
    } else {
      choose.value = label;
    }
  }
}
