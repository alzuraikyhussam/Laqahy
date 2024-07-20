import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/child_visit_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class ChildVisitController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var childStatement = [].obs;
  var filteredChildStatement = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
    TextEditingController childStatementSearchController =
      TextEditingController();
  GlobalKey<FormState> createChildStatementDataFormKey = GlobalKey<FormState>();
  int? centerId;

  @override
  onInit() async {
    centerId = await sdc.storageService.getCenterId();
    sdc.fetchMothers();
    fetchChildrenStatement();
    sdc.fetchVisitType();
    super.onInit();
  }

  void clearTextFields() {
    sdc.selectedChildsId.value = null;
    sdc.selectedMothersId.value = null;
    sdc.selectedVisitType.value = null;
    sdc.selectedVaccineType.value = null;
    sdc.selectedChildDosageTypeId.value = null;
  }

    void filterChildStatement(String keyword) {
    filteredChildStatement.value = childStatement.where((childrenStatement) {
      return childrenStatement.childName
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchChildrenStatement() async {
    try {
      isLoading(true);
      childStatementSearchController.clear();
      final response = await http.get(
        Uri.parse(ApiEndpoints.getChildStatementData),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        childStatement.value =
            jsonData.map((e) => ChildrenStatement.fromJson(e)).toList();
        filteredChildStatement.value = childStatement;
      } else if (response.statusCode == 500) {
        isLoading(false);
        ApiExceptionWidgets().myFetchDataExceptionAlert(response.statusCode);
        print(response.body);
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        print(response.body);
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

  Future<void> addChildrenStatement() async {
    int? centerID = await sdc.storageService.getCenterId();
    int? userID = await sdc.userLoggedData.first.userId;
    DateTime date_taking_dose = DateTime.now();
    DateTime returnDate = date_taking_dose.add(const Duration(days: 28));
    try {
      isAddLoading(true);
      final motherStatement = ChildrenStatement(
        childDataId: sdc.selectedChildsId.value!,
        healthyCenterId: centerID!,
        userId: userID!,
        dateTakingDose: date_taking_dose,
        returnDate: returnDate,
        childDosageTypeId: sdc.selectedChildDosageTypeId.value!,
        visitTypeId: sdc.selectedVisitType.value!,
        vaccineTypeId: sdc.selectedVaccineType.value!,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addChildStatementData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(motherStatement.toJson()),
      );

      if (response.statusCode == 201) {
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
        clearTextFields();
        fetchChildrenStatement();
        isAddLoading(false);

        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
        print(response.body);
        return;
      } else {
        isAddLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        print(response.body);
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

  Future<void> deleteChildStatement(int childId) async {
    isDeleteLoading(true);
    try {
      var request = await http
          .delete(Uri.parse('${ApiEndpoints.deleteChildStatementData}/$childId'));

      if (request.statusCode == 200) {
        await fetchChildrenStatement();
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
