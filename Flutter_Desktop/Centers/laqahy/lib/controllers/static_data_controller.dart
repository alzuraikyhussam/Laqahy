import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/city_model.dart';
import 'package:laqahy/models/directorate_model.dart';
import 'package:laqahy/models/dosage_level_model.dart';
import 'package:laqahy/models/dosage_type_model.dart';
import 'package:laqahy/models/gender_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/mother_status_data_model.dart';
import 'package:laqahy/models/permission_type_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/storage/storage_service.dart';

class StaticDataController extends GetxController {
  List<Login> userLoggedData = <Login>[].obs;
  List<HealthyCenter> centerData = <HealthyCenter>[].obs;

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

  var mothers = <Mothers>[].obs;
  var selectedMothersId = Rx<int?>(null);
  var motherErrorMsg = ''.obs;
  var isMotherLoading = false.obs;

  var dosageLevel = <DosageLevel>[].obs;
  var selectedDosageLevelId = Rx<int?>(null);
  var dosageLevelErrorMsg = ''.obs;
  var isDosageLevelLoading = false.obs;

  var dosageType = <DosageType>[].obs;
  var selectedDosageTypeId = Rx<int?>(null);
  var dosageTypeErrorMsg = ''.obs;
  var isDosageTypeLoading = false.obs;

  @override
  void onInit() async {
    updateGreeting();
    startTimer();
    fetchPermissions();
    fetchGenders();
    fetchCities();
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
      genderErrorMsg('خطأ غير متوقع\n${e.toString()}');
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
      permissionErrorMsg('خطأ غير متوقع\n${e.toString()}');
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
      cityErrorMsg('خطأ غير متوقع\n${e.toString()}');
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
      directorateErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDirectorateLoading(false);
    }
  }

  void fetchMothers() async {
    try {
      motherErrorMsg('');
      isMotherLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getMothersData),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isMotherLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Mothers> fetchedMothers =
            jsonData.map((e) => Mothers.fromJson(e)).toList();
        mothers.assignAll(fetchedMothers);
      } else {
        isMotherLoading(false);
        motherErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isMotherLoading(false);
      motherErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isMotherLoading(false);
      motherErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isMotherLoading(false);
    }
  }

  void fetchDosageLevel() async {
    try {
      dosageLevelErrorMsg('');
      isDosageLevelLoading(true);
      final response = await http.get(
        Uri.parse('ApiEndpoints.getDosageLeve;'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDosageLevelLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<DosageLevel> fetchDosageLevelData =
            jsonData.map((e) => DosageLevel.fromJson(e)).toList();
        dosageLevel.assignAll(fetchDosageLevelData);
      } else {
        isDosageLevelLoading(false);
        dosageLevelErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDosageLevelLoading(false);
      dosageLevelErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDosageLevelLoading(false);
      dosageLevelErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDosageLevelLoading(false);
    }
  }

  void fetchDosageType(int dosageLevelId) async {
    try {
      dosageTypeErrorMsg('');
      isDosageTypeLoading(true);
      final response = await http.get(
        Uri.parse('{ApiEndpoints.getDosageType}/$dosageLevelId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDosageTypeLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<DosageType> fetchDosageTypeData =
            jsonData.map((e) => DosageType.fromJson(e)).toList();
        dosageType.assignAll(fetchDosageTypeData);
      } else {
        isDosageTypeLoading(false);
        dosageTypeErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDosageTypeLoading(false);
      dosageTypeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDosageTypeLoading(false);
      dosageTypeErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDosageTypeLoading(false);
    }
  }
}
