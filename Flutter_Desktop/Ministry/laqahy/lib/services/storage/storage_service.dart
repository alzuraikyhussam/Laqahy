import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences prefs;

  static Future<StorageService> getInstance() async {
    final instance = StorageService();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setCenterId(int centerId) async {
    await prefs.setInt('centerId', centerId);
  }

  Future<void> setRegistered(bool isRegistered) async {
    StaticDataController controller = Get.find<StaticDataController>();
    await prefs.setBool('isRegistered', isRegistered);
    controller.isRegistered.value = isRegistered;
  }

  Future<int?> getCenterId() async {
    return prefs.getInt('centerId') ?? 0;
  }

  Future<bool> isRegistered() async {
    return prefs.getBool('isRegistered') ?? false;
  }
}
