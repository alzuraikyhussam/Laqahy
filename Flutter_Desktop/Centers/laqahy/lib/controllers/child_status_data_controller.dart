import 'dart:convert';
import 'dart:io';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/child_status_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class ChildStatusDataController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var children = [].obs;
  var isLoading = true.obs;
  var filteredChildrenStatusData = [].obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  GlobalKey<FormState> createChildStatusDataFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editChildStatusDataFormKey = GlobalKey<FormState>();
  TextEditingController childStatusDataSearchController =
      TextEditingController();
  TextEditingController nameController = TextEditingController();

  int? centerId;

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
  TextEditingController birthDateController = TextEditingController();
  String? birthDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  //////////

  void clearTextFields() {
    nameController.clear();
    birthDateController.clear();
    sdc.selectedMothersId.value = null;
    sdc.selectedGenderId.value = null;
    sdc.selectedCityId.value = null;
    sdc.selectedDirectorateId.value = null;
    sdc.selectedMothersId.value = null;
    birthPlaceController.clear();
  }

  //////////
  TextEditingController birthPlaceController = TextEditingController();
  String? birthPlaceValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال مكان ميلاد الطفل';
    }
    return null;
  }

  @override
  onInit() async {
    centerId = await sdc.storageService.getCenterId();
    fetchAllChildrenStatusData();
    sdc.fetchGenders();
    // fetchUsers(centerId);
    // sdc.fetchCities();
    super.onInit();
  }

  void filterChildrenStatusData(String keyword) {
    filteredChildrenStatusData.value = children.where((child) {
      return child.child_data_name
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchAllChildrenStatusData() async {
    try {
      isLoading(true);
      childStatusDataSearchController.clear();
      final response = await http.get(
        Uri.parse(ApiEndpoints.getAllChildrenStatusData),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        children.value = jsonData.map((e) => Children.fromJson(e)).toList();
        filteredChildrenStatusData.value = children;
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

  Future<void> addChildStatusData() async {
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);
    try {
      isAddLoading(true);
      final child = Children(
        child_data_name: nameController.text,
        child_data_birthplace: birthPlaceController.text,
        child_data_birthDate: parsedBirthDate,
        mother_data_id: sdc.selectedMothersId.value!,
        gender_id: sdc.selectedGenderId.value!,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addChildStatusData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(child.toJson()),
      );

      if (response.statusCode == 201) {
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
        fetchAllChildrenStatusData();
        clearTextFields();
        isAddLoading(false);
        // await fetchUsers(centerId);

        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
        return;
      } else {
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
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }


  Future<void> updateChildStatusData(
    var childId,
    var name,
    var birthplace,
    var birthDate,
    var motherName,
    var genderType,
  ) async {
    try {
      DateTime parsedBirthDate = DateFormat('MMM d, yyyy').parse(birthDate);
      isUpdateLoading(true);
      final child = Children(
        child_data_name: name,
        child_data_birthplace: birthplace,
        child_data_birthDate: parsedBirthDate,
        mother_data_id: motherName,
        gender_id: genderType,
      );
      var request = http.MultipartRequest('POST',
          Uri.parse('${ApiEndpoints.updateChildChildrenStatusData}/$childId'));
      request.fields['_method'] = 'PATCH';
      request.fields['child_data_name'] = child.child_data_name;
      request.fields['child_data_birthplace'] = child.child_data_birthplace;
      request.fields['child_data_birthDate'] =
          DateFormat('yyyy-MM-dd').format(child.child_data_birthDate);
      request.fields['mother_data_id'] = child.mother_data_id.toString();
      request.fields['gender_id'] = child.gender_id.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        await fetchAllChildrenStatusData();
        Get.back();
        ApiExceptionWidgets().myUpdateDataSuccessAlert();
        sdc.fetchMothers();
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


  Future<void> deleteChildStatusData(int childId) async {
    isDeleteLoading(true);
    try {
      var request = await http.delete(
          Uri.parse('${ApiEndpoints.deleteChildChildrenStatusData}/$childId'));

      if (request.statusCode == 200) {
        await fetchAllChildrenStatusData();
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
}
