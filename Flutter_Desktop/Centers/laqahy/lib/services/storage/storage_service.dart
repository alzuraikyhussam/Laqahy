import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences prefs;

  static Future<StorageService> getInstance() async {
    final instance = StorageService();
    await instance.init();
    return instance;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setCenterId(int centerId) async {
    await prefs.setInt('centerId', centerId);
  }

  Future<void> setAdminId(int adminId) async {
    await prefs.setInt('adminId', adminId);
  }

  Future<void> setRegistered(bool isRegistered) async {
  StaticDataController controller = Get.find<StaticDataController>();
    await prefs.setBool('isRegistered', isRegistered);
    controller.isRegistered.value = isRegistered;
  }

  Future<int?> getCenterId() async {
    return prefs.getInt('centerId') ?? 0;
  }

  Future<int?> getAdminId() async {
    return prefs.getInt('adminId') ?? 0;
  }

  Future<bool> isRegistered() async {
    return prefs.getBool('isRegistered') ?? false;
  }

  Future<bool> setThemeMode(bool isDark) async {
    return prefs.setBool('isDark', isDark);
  }

  Future<bool?> isDarkMode() async {
    return prefs.getBool('isDark');
  }
}
