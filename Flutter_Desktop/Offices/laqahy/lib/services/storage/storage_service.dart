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

  Future<void> setOfficeId(int officeId) async {
    await prefs.setInt('officeId', officeId);
  }

  Future<void> setAdminId(int adminId) async {
    await prefs.setInt('adminId', adminId);
  }

  Future<void> setRegistered(bool isRegistered) async {
    StaticDataController controller = Get.find<StaticDataController>();
    await prefs.setBool('isRegistered', isRegistered);
    controller.isRegistered.value = isRegistered;
  }

  Future<int?> getOfficeId() async {
    return prefs.getInt('officeId') ?? 0;
  }

  Future<int?> getAdminId() async {
    return prefs.getInt('adminId') ?? 0;
  }

  Future<bool> isRegistered() async {
    return prefs.getBool('isRegistered') ?? false;
  }
}
