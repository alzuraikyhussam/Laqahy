import 'dart:convert';
import 'dart:io';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/utils/pdf/mother_visit_data_pdf_generator.dart';
import 'package:laqahy/models/mother_visit_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class MotherVisitController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();

  var motherStatement = [].obs;
  var filteredMotherStatement = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  TextEditingController motherStatementSearchController =
      TextEditingController();
  GlobalKey<FormState> createMotherStatementFormKey = GlobalKey<FormState>();

  int? dosageLevelId;

  void clearTextFields() {
    // sdc.selectedAllMothersId.value = null;
    sdc.selectedDosageLevelId.value = null;
    sdc.selectedDosageTypeId.value = null;
  }

  @override
  onInit() async {
    clearTextFields();
    sdc.fetchAllMothers();
    sdc.fetchDosageLevel();
    super.onInit();
  }

  void filterMotherStatement(String keyword) {
    filteredMotherStatement.value = motherStatement.where((motherStatements) {
      return motherStatements.dosage_level
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchMotherStatement(int motherId) async {
    try {
      isLoading(true);
      motherStatementSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getMotherStatement}/$motherId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        motherStatement.value =
            jsonData.map((e) => MotherStatement.fromJson(e)).toList();
        filteredMotherStatement.value = motherStatement;
      } else if (response.statusCode == 500) {
        isLoading(false);
        ApiExceptionWidgets().myFetchDataExceptionAlert(response.statusCode);
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

  Future<void> addMotherStatement() async {
    int? centerID = await sdc.storageService.getCenterId();
    int? userID = await sdc.userLoggedData.first.userId;
    DateTime date_taking_dose = DateTime.now();
    DateTime returnDate = date_taking_dose.add(const Duration(days: 28));
    try {
      isAddLoading(true);
      final motherStatement = MotherStatement(
        mother_data_id: sdc.selectedAllMothersId.value!,
        healthy_center_id: centerID!,
        user_id: userID!,
        date_taking_dose: date_taking_dose,
        return_date: returnDate,
        dosage_type_id: sdc.selectedDosageTypeId.value!,
        dosage_level_id: sdc.selectedDosageLevelId.value!,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addMotherStatement),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(motherStatement.toJson()),
      );

      if (response.statusCode == 201) {
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
        printMotherVisitData(
            sdc.selectedAllMothersId.value!.toString(),
            sdc.selectedDosageLevelId.value!.toString(),
            sdc.selectedDosageTypeId.value!.toString());
        await fetchMotherStatement(sdc.selectedAllMothersId.value!);
        clearTextFields();
        isAddLoading(false);

        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
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

  Future<void> deleteMotherStatement(int motherId) async {
    isDeleteLoading(true);
    try {
      print(motherId);
      var request = await http
          .delete(Uri.parse('${ApiEndpoints.deleteMotherStatement}/$motherId'));

      if (request.statusCode == 200) {
        await fetchMotherStatement(sdc.selectedAllMothersId.value!);
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

  Future<void> printMotherVisitData(
      String mother_data_id, String dosageLevel, String dosageType) async {
    try {
      isLoading(true);
      motherStatementSearchController.clear();
      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.printMotherVisitData}/$mother_data_id/$dosageLevel/$dosageType'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        motherStatement.value =
            jsonData.map((e) => MotherStatement.fromJson(e)).toList();

        MotherVisitDataPdfGenerator mpg = MotherVisitDataPdfGenerator(
            data: motherStatement, reportName: 'بيانات زيارة الام');
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
