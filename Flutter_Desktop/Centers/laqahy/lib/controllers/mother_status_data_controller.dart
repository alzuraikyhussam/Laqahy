import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/utils/pdf/mother_status_data_pdf_generator.dart';
import 'package:laqahy/models/mother_status_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:uuid/uuid.dart';

class MotherStatusDataController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var mothers = [].obs;
  var filteredMothersStatusData = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  GlobalKey<FormState> createMotherStatusDataFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editMotherStatusDataFormKey = GlobalKey<FormState>();
  TextEditingController motherStatusDataSearchController =
      TextEditingController();
  TextEditingController nameController = TextEditingController();

  int? centerId;

  Uuid createAccountCode = const Uuid();

  String? password;

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الاسم الرباعي';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يجب أن يحتوي الاسم على أرقام أو رموز';
    } else if (!RegExp(r'^\S+(\s+\S+){3}$').hasMatch(value)) {
      // Regular expression to match exactly four words separated by spaces
      return 'يجب ادخال الاسم الرباعي';
    }
    return null;
  }

/////////////
  TextEditingController phoneNumberController = TextEditingController();
  String? phoneNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال رقم الجوال ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9 ارقام';
    }
    return null;
  }

/////////////
  TextEditingController identityNumberController = TextEditingController();
  String? identityNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الرقم الوطني ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthBetween(value, 6, 9)) {
      return 'يجب أن يكون ما بين 8 الى 12 رقم';
    }
    return null;
  }

/////////////
  TextEditingController birthDateController = TextEditingController();
  String? birthDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  //////////
  TextEditingController villageController = TextEditingController();
  String? villageValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال اسم العزلة / القرية';
    }
    return null;
  }

  void clearTextFields() {
    nameController.clear();
    identityNumberController.clear();
    phoneNumberController.clear();
    birthDateController.clear();
    sdc.selectedCityId.value = null;
    sdc.selectedDirectorateId.value = null;
    villageController.clear();
  }

  @override
  onInit() async {
    centerId = await sdc.storageService.getCenterId();
    password = createAccountCode.v4().substring(0, 8);
    fetchAllMothersStatusData(centerId!);
    sdc.fetchCities();
    clearTextFields();
    super.onInit();
  }

  void filterMotherStatusData(String keyword) {
    filteredMothersStatusData.value = mothers.where((mother) {
      return mother.mother_name
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchAllMothersStatusData(int centerId) async {
    try {
      isLoading(true);
      motherStatusDataSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getAllMotherStatusDate}/$centerId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        mothers.value = jsonData.map((e) => Mothers.fromJson(e)).toList();
        filteredMothersStatusData.value = mothers;
      } else if (response.statusCode == 500) {
        isLoading(false);
        ApiExceptionWidgets().myFetchDataExceptionAlert(response.statusCode);
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addMotherStatusData() async {
    int? centerID = await sdc.storageService.getCenterId();
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);

    try {
      isAddLoading(true);
      final Mother = Mothers(
        mother_name: nameController.text,
        mother_phone: phoneNumberController.text,
        mother_village: villageController.text,
        mother_birthDate: parsedBirthDate,
        mother_identity_num: identityNumberController.text,
        mother_password: password!,
        cities_id: sdc.selectedCityId.value!,
        directorate_id: sdc.selectedDirectorateId.value!,
        healthy_center_id: centerID!,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addMotherStatusData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(Mother.toJson()),
      );

      if (response.statusCode == 201) {
        Get.back();
        printMotherStatusData(identityNumberController.text);
        ApiExceptionWidgets().myAddedDataSuccessAlert();

        // var data = json.decode(response.body);
        // Mothers motherData = Mothers.fromJson(data['mother']);
        // print(data);

        sdc.fetchMothers();
        fetchAllMothersStatusData(centerId!);
        clearTextFields();
        isAddLoading(false);
        // await fetchUsers(centerId);
        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
        return;
      } else {
        print(response.body);
        isAddLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      print(e);
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> deleteMotherStatusData(int motherId) async {
    isDeleteLoading(true);
    try {
      var request = await http.delete(
          Uri.parse('${ApiEndpoints.deleteMotherStatusData}/$motherId'));

      if (request.statusCode == 200) {
        await fetchAllMothersStatusData(centerId!);
        Get.back();
        ApiExceptionWidgets().myDeleteDataSuccessAlert();
        isDeleteLoading(false);

        return;
      } else {
        isDeleteLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(request.statusCode);
        print(request.body);
      }
    } on SocketException catch (_) {
      isDeleteLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isDeleteLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isDeleteLoading(false);
    }
  }

  Future<void> updateMotherStatusData(
    var motherId,
    var name,
    var identityNumber,
    var phoneNumber,
    var birthDate,
    var cityName,
    var directorateName,
    var villageName,
  ) async {
    try {
      DateTime parsedBirthDate = DateFormat('MMM d, yyyy').parse(birthDate);
      isUpdateLoading(true);
      final mother = Mothers(
        mother_password: password!,
        healthy_center_id: centerId!,
        mother_name: name,
        mother_phone: phoneNumber,
        mother_identity_num: identityNumber,
        mother_village: villageName,
        mother_birthDate: parsedBirthDate,
        cities_id: cityName,
        directorate_id: directorateName,
      );
      var request = http.MultipartRequest('POST',
          Uri.parse('${ApiEndpoints.updateMotherStatusData}/$motherId'));
      request.fields['_method'] = 'PATCH';
      request.fields['mother_name'] = mother.mother_name;
      request.fields['mother_phone'] = mother.mother_phone;
      request.fields['mother_identity_num'] = mother.mother_identity_num;
      request.fields['mother_birthDate'] =
          DateFormat('yyyy-MM-dd').format(mother.mother_birthDate);
      request.fields['mother_password'] = mother.mother_password;
      request.fields['mother_village'] = mother.mother_village;
      request.fields['cities_id'] = mother.cities_id.toString();
      request.fields['directorate_id'] = mother.directorate_id.toString();
      request.fields['healthy_center_id'] = mother.healthy_center_id.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        // await fetchAllMothersStatusData(centerId!);
        Get.back();
        ApiExceptionWidgets().myUpdateDataSuccessAlert();
        sdc.fetchMothers();
        fetchAllMothersStatusData(sdc.centerData.first.id!);
        isUpdateLoading(false);
        clearTextFields();
        return;
      } else if (response.statusCode == 401) {
        isUpdateLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
        return;
      } else {
        isUpdateLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isUpdateLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUpdateLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUpdateLoading(false);
    }
  }

  Future<void> printMotherStatusData(String identityNumber) async {
    try {
      isLoading(true);
      motherStatusDataSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.printMotherStatusData}/$identityNumber'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        mothers.value = jsonData.map((e) => Mothers.fromJson(e)).toList();

        MotherStatusDataPdfGenerator mpg = MotherStatusDataPdfGenerator(
            data: mothers, reportName: 'بيانات الحالة');
        await mpg.generatePdf(Get.context!);
      } else if (response.statusCode == 500) {
        isLoading(false);
        ApiExceptionWidgets().myFetchDataExceptionAlert(response.statusCode);
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
