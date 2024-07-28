import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/child_status_data_model.dart';
import 'package:laqahy/models/city_model.dart';
import 'package:laqahy/models/directorate_model.dart';
import 'package:laqahy/models/dosage_level_model.dart';
import 'package:laqahy/models/dosage_type_model.dart';
import 'package:laqahy/models/dosage_with_vaccine_model.dart';
import 'package:laqahy/models/gender_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/mother_status_data_model.dart';
import 'package:laqahy/models/permission_type_model.dart';
import 'package:laqahy/models/login_model.dart';
import 'package:laqahy/models/vaccine_model.dart';
import 'package:laqahy/models/vaccine_with_visit_model.dart';
import 'package:laqahy/models/visit_type_model.dart';
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

  var allMothers = <Mothers>[].obs;
  var selectedAllMothersId = Rx<int?>(null);
  var allMotherErrorMsg = ''.obs;
  var isAllMotherLoading = false.obs;

  var childs = <Children>[].obs;
  var selectedChildsId = Rx<int?>(null);
  var childErrorMsg = ''.obs;
  var isChildLoading = false.obs;

  var dosageLevel = <DosageLevel>[].obs;
  var selectedDosageLevelId = Rx<int?>(null);
  var dosageLevelErrorMsg = ''.obs;
  var isDosageLevelLoading = false.obs;

  var dosageType = <DosageType>[].obs;
  var selectedDosageTypeId = Rx<int?>(null);
  var dosageTypeErrorMsg = ''.obs;
  var isDosageTypeLoading = false.obs;

  var childDosageType = <DosageWithVaccine>[].obs;
  var selectedChildDosageTypeId = Rx<int?>(null);
  var childDosageTypeErrorMsg = ''.obs;
  var isChildDosageTypeLoading = false.obs;

  var vaccines = <Vaccine>[].obs;
  var selectedVaccine = Rx<Vaccine?>(null);
  var vaccineErrorMsg = ''.obs;
  var isVaccineLoading = false.obs;

  var vaccineType = <VaccineWithVisit>[].obs;
  var selectedVaccineType = Rx<int?>(null);
  var vaccineTypeErrorMsg = ''.obs;
  var isVaccineTypeLoading = false.obs;

  var visitType = <VisitType>[].obs;
  var selectedVisitType = Rx<int?>(null);
  var visitTypeErrorMsg = ''.obs;
  var isVisitTypeLoading = false.obs;

  @override
  void onInit() async {
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

  void fetchMothers(int healthyCenterId) async {
    try {
      motherErrorMsg('');
      isMotherLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getMothersData}/$healthyCenterId'),
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
      motherErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isMotherLoading(false);
    }
  }

  void fetchAllMothers() async {
    try {
      allMotherErrorMsg('');
      isAllMotherLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getAllMothersData),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isAllMotherLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Mothers> fetchedAllMothers =
            jsonData.map((e) => Mothers.fromJson(e)).toList();
        allMothers.assignAll(fetchedAllMothers);
      } else {
        isAllMotherLoading(false);
        allMotherErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isAllMotherLoading(false);
      allMotherErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isAllMotherLoading(false);
      allMotherErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isAllMotherLoading(false);
    }
  }

  void fetchChildren(int motherId) async {
    try {
      childErrorMsg('');
      isChildLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getChildData}/$motherId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isChildLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Children> fetchedChildren =
            jsonData.map((e) => Children.fromJson(e)).toList();
        childs.assignAll(fetchedChildren);
      } else {
        isChildLoading(false);
        childErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isChildLoading(false);
      childErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isChildLoading(false);
      childErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isChildLoading(false);
    }
  }

  void fetchDosageLevel() async {
    try {
      dosageLevelErrorMsg('');
      isDosageLevelLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getDosageLevel),
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
      dosageLevelErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isDosageLevelLoading(false);
    }
  }

  void fetchDosageType(int dosageLevelId, int motherId) async {
    try {
      dosageTypeErrorMsg('');
      isDosageTypeLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getDosageType}/$dosageLevelId/$motherId'),
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
        print(response.body);
      }
    } on SocketException catch (_) {
      isDosageTypeLoading(false);
      dosageTypeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDosageTypeLoading(false);
      dosageTypeErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isDosageTypeLoading(false);
    }
  }

  void fetchVisitType() async {
    try {
      visitTypeErrorMsg('');
      isVisitTypeLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getVisitType),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isVisitTypeLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<VisitType> fetchVisitTypes =
            jsonData.map((e) => VisitType.fromJson(e)).toList();
        visitType.assignAll(fetchVisitTypes);
      } else {
        isVisitTypeLoading(false);
        visitTypeErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
        print(response.body);
      }
    } on SocketException catch (_) {
      isVisitTypeLoading(false);
      visitTypeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isVisitTypeLoading(false);
      visitTypeErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isVisitTypeLoading(false);
    }
  }

  void fetchVaccineWithVisit(int visitTypeId) async {
    try {
      vaccineTypeErrorMsg('');
      isVaccineTypeLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getVaccinesType}/$visitTypeId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isVaccineTypeLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<VaccineWithVisit> fetchVaccineWithVisit =
            jsonData.map((e) => VaccineWithVisit.fromJson(e)).toList();
        vaccineType.assignAll(fetchVaccineWithVisit);
      } else {
        isVaccineTypeLoading(false);
        vaccineTypeErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
        print(response.body);
      }
    } on SocketException catch (_) {
      isVaccineTypeLoading(false);
      vaccineTypeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      print(e);
      isVaccineTypeLoading(false);
      vaccineTypeErrorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isVaccineTypeLoading(false);
    }
  }

  void fetchDosageWithVaccine(
      int vaccineTypeId, int visitType, int childId) async {
    try {
      childDosageTypeErrorMsg('');
      isChildDosageTypeLoading(true);
      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.getDosageTypeWithVaccine}/$vaccineTypeId/$visitType/$childId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isChildDosageTypeLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<DosageWithVaccine> fetchDosageWithVaccine =
            jsonData.map((e) => DosageWithVaccine.fromJson(e)).toList();
        childDosageType.assignAll(fetchDosageWithVaccine);
      } else {
        isChildDosageTypeLoading(false);
        childDosageTypeErrorMsg(
            'فشل في تحميل البيانات\n${response.statusCode}');
        print(response.body);
      }
    } on SocketException catch (_) {
      isChildDosageTypeLoading(false);
      childDosageTypeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      print(e);
      isChildDosageTypeLoading(false);
      childDosageTypeErrorMsg(
          'لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
    } finally {
      isChildDosageTypeLoading(false);
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
        },
      );
      if (response.statusCode == 200) {
        isVaccineLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Vaccine> fetchedVaccine =
            jsonData.map((e) => Vaccine.fromJson(e)).toList();
        vaccines.assignAll(fetchedVaccine);
      } else {
        print(response.body);
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
