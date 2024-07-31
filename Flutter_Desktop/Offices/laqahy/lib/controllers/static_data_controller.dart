import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/city_model.dart';
import 'package:laqahy/models/directorate_model.dart';
import 'package:laqahy/models/gender_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/models/permission_type_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/vaccine_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/storage/storage_service.dart';

class StaticDataController extends GetxController {
  List<Login> userLoggedData = <Login>[].obs;
  List<Office> officeData = <Office>[].obs;

  late StorageService storageService;
  late var isRegistered = false.obs;

  final greeting = ''.obs;
  Timer? timer;

  // final macAddress = ''.obs;
  // final deviceName = ''.obs;
  // final deviceUserName = ''.obs;

  var genders = <Gender>[].obs;
  var selectedGenderId = Rx<int?>(null);
  var genderErrorMsg = ''.obs;
  var isGenderLoading = false.obs;

  var permissions = <PermissionType>[].obs;
  var selectedPermissionId = Rx<int?>(null);
  var permissionErrorMsg = ''.obs;
  var isPermissionLoading = false.obs;

  var cities = <City>[].obs;
  var selectedCityId = Rx<int?>(null);
  var cityErrorMsg = ''.obs;
  var isCityLoading = false.obs;

  var directorates = <Directorate>[].obs;
  var selectedDirectorateId = Rx<int?>(null);
  var directorateErrorMsg = ''.obs;
  var isDirectorateLoading = false.obs;

  var vaccines = <Vaccine>[].obs;
  var selectedVaccine = Rx<Vaccine?>(null);
  var vaccineErrorMsg = ''.obs;
  var isVaccineLoading = false.obs;

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  void onInit() async {
    sanctumToken = await storage.read(key: 'token');
    updateGreeting();
    startTimer();
    storageService = await StorageService.getInstance();
    isRegistered.value = await storageService.isRegistered();
    super.onInit();
  }

  // Future initWindowsSystemInfo() async {
  //   await WindowsSystemInfo.initWindowsInfo();
  //   try {
  //     if (await WindowsSystemInfo.isInitilized) {
  //       final networkInfo = WindowsSystemInfo.network.map((e) => e.mac);
  //       final macAddress = networkInfo.toString();
  //       final deviceName = WindowsSystemInfo.deviceName;
  //       final deviceUserName = WindowsSystemInfo.userName;
  //       return [macAddress, deviceName, deviceUserName];
  //     }
  //   } catch (_) {
  //     log(_.toString());
  //   }
  // }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      updateGreeting();
    });
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    greeting.value = (hour < 12) ? 'صبـاح الخيــر' : 'مسـاء الخيــر';
  }

  void fetchGenders() async {
    try {
      genderErrorMsg('');
      isGenderLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getGenders),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isGenderLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Gender> fetchedGender =
            jsonData.map((e) => Gender.fromJson(e)).toList();
        genders.assignAll(fetchedGender);
      } else {
        isGenderLoading(false);
        genderErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isGenderLoading(false);
      genderErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isGenderLoading(false);
      genderErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isGenderLoading(false);
    }
  }

  void fetchPermissions() async {
    try {
      permissionErrorMsg('');
      isPermissionLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getPermissions),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isPermissionLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<PermissionType> fetchedPermission =
            jsonData.map((e) => PermissionType.fromJson(e)).toList();
        permissions.assignAll(fetchedPermission);
      } else {
        isPermissionLoading(false);
        permissionErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isPermissionLoading(false);
      permissionErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isPermissionLoading(false);
      permissionErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isPermissionLoading(false);
    }
  }

  void fetchCities() async {
    try {
      cityErrorMsg('');
      isCityLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getCities),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isCityLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<City> fetchedCities =
            jsonData.map((e) => City.fromJson(e)).toList();
        cities.assignAll(fetchedCities);
      } else {
        isCityLoading(false);
        cityErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isCityLoading(false);
      cityErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isCityLoading(false);
      cityErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isCityLoading(false);
    }
  }

  void fetchDirectorates(int cityId) async {
    try {
      directorateErrorMsg('');
      isDirectorateLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getDirectorates}/$cityId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDirectorateLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Directorate> fetchedDirectorates =
            jsonData.map((e) => Directorate.fromJson(e)).toList();
        directorates.assignAll(fetchedDirectorates);
      } else {
        isDirectorateLoading(false);
        directorateErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDirectorateLoading(false);
      directorateErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDirectorateLoading(false);
      directorateErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isDirectorateLoading(false);
    }
  }

  Future<void> fetchVaccines() async {
    try {
      vaccineErrorMsg('');
      isVaccineLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getVaccines),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
      );
      if (response.statusCode == 200) {
        isVaccineLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Vaccine> fetchedVaccine =
            jsonData.map((e) => Vaccine.fromJson(e)).toList();
        vaccines.assignAll(fetchedVaccine);
      } else {
        isVaccineLoading(false);
        vaccineErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isVaccineLoading(false);
      vaccineErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isVaccineLoading(false);
      vaccineErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isVaccineLoading(false);
    }
  }
}
