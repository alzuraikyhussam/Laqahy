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

  Future<void> setRegistered(bool isRegistered) async {
    await prefs.setBool('isRegistered', isRegistered);
  }

  Future<void> setFingerprintEnabled(bool isFingerprintEnabled) async {
    await prefs.setBool('isFingerprintEnabled', isFingerprintEnabled);
  }

  Future<bool> isRegistered() async {
    return prefs.getBool('isRegistered') ?? false;
  }

  Future<bool> isFingerprintEnabled() async {
    return prefs.getBool('isFingerprintEnabled') ?? false;
  }

  Future<void> setMotherId(int motherId) async {
    await prefs.setInt('motherId', motherId);
  }

  Future<int?> getMotherId() async {
    return prefs.getInt('motherId');
  }
}
