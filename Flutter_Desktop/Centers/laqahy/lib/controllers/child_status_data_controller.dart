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
  var child = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  GlobalKey<FormState> createChildStatusDataFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  int? centerId;

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الاسم الرباعي';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يجب أن يحتوي الاسم على أرقام أو رموز';
    } else if (!RegExp(r'^\S+(\s+\S+){3}$').hasMatch(value)) {
      // Regular expression to match exactly four words separated by spaces
      return 'يجب ادخال اسمك الرباعي';
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
    // fetchUsers(centerId);
    // sdc.fetchCities();
    super.onInit();
  }

  Future<void> addChildStatusData() async {
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);
    try {
      isAddLoading(true);
      final Child = Childs(
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
        body: jsonEncode(Child.toJson()),
      );

      if (response.statusCode == 201) {
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
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
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }
}
