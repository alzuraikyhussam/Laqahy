import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  RxString choose = 'الرئيسية'.obs;

  changeChoose(String label) {
    if (label == 'تسجيل الخروج') {
      choose.value = 'الرئيسية';
      print('logout');
    } else {
      choose.value = label;
    }
  }
}
