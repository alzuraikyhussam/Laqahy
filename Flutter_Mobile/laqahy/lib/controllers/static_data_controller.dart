import 'dart:async';

import 'package:get/get.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/services/storage/storage_service.dart';

class StaticDataController extends GetxController {
  List<Login> userLoggedData = <Login>[].obs;

  late StorageService storageService;
  late var isRegistered = false.obs;

  final greeting = ''.obs;
  Timer? timer;

  @override
  void onInit() async {
    updateGreeting();
    startTimer();
    storageService = await StorageService.getInstance();
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      updateGreeting();
    });
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    greeting.value = (hour < 12) ? 'صبـاح الخيــر' : 'مسـاء الخيــر';
  }
}
