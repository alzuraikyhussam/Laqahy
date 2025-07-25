import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/utils/pdf/child_visit_data_pdf_generator.dart';
import 'package:laqahy/models/child_visit_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class ChildVisitController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var childStatement = [].obs;
  var printedChildStatement = [].obs;
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

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  onInit() async {
    sanctumToken = await storage.read(key: 'token');
    centerId = await sdc.storageService.getCenterId();
    sdc.fetchAllMothers();
    sdc.fetchVisitType();
    super.onInit();
  }

  void clearTextFields() {
    // sdc.selectedChildsId.value = null;
    // sdc.selectedAllMothersId.value = null;
    sdc.selectedVisitType.value = null;
    sdc.selectedVaccineType.value = null;
    sdc.selectedChildDosageTypeId.value = null;
  }

  void filterChildStatement(String keyword) {
    filteredChildStatement.value = childStatement.where((childrenStatement) {
      return childrenStatement.visitType
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          childrenStatement.vaccineType
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchChildrenStatement(int childId) async {
    try {
      isLoading(true);
      childStatementSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getChildStatementData}/$childId'),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
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
      ApiExceptionWidgets().myUnknownExceptionAlert();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addChildrenStatement() async {
    int? centerID = await sdc.storageService.getCenterId();
    int? userID = sdc.userLoggedData.first.userId;
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
          'Authorization': 'Bearer $sanctumToken',
        },
        body: jsonEncode(motherStatement.toJson()),
      );

      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        var quantity = data['quantity'];

        ApiExceptionWidgets().myAddedDosageWithQuantityAlert(
          quantity: quantity,
          title: 'تمت العملية بنجاح',
          description: 'لقد تمت عملية إضافة الجرعة بنجاح',
        );

        await printChildVisitData(
          sdc.selectedChildsId.value.toString(),
          sdc.selectedVisitType.value.toString(),
          sdc.selectedVaccineType.value.toString(),
          sdc.selectedChildDosageTypeId.value.toString(),
        );

        // ApiExceptionWidgets().myAddedDataSuccessAlert();

        await fetchChildrenStatement(sdc.selectedChildsId.value!);

        clearTextFields();

        isAddLoading(false);

        return;
      } else if (response.statusCode == 405) {
        var data = json.decode(response.body);
        var quantity = data['quantity'];
        ApiExceptionWidgets().myVaccineQtyNotEnoughAlert(quantity: quantity);
        isAddLoading(false);
        return;
      } else {
        isAddLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert();
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> deleteChildStatement(int id) async {
    isDeleteLoading(true);
    try {
      var request = await http.delete(
        Uri.parse('${ApiEndpoints.deleteChildStatementData}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
      );

      if (request.statusCode == 200) {
        await fetchChildrenStatement(sdc.selectedChildsId.value!);
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
      ApiExceptionWidgets().myUnknownExceptionAlert();
      return;
    } finally {
      isDeleteLoading(false);
    }
  }

  Future<void> printChildVisitData(String childDataId, String visitTypeId,
      String vaccineTypeId, String childDosageTypeId) async {
    try {
      isLoading(true);
      childStatementSearchController.clear();
      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.printChildVisitData}/$childDataId/$visitTypeId/$vaccineTypeId/$childDosageTypeId'),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        printedChildStatement.value =
            jsonData.map((e) => ChildrenStatement.fromJson(e)).toList();

        ChildVisitDataPdfGenerator mpg = ChildVisitDataPdfGenerator(
            data: printedChildStatement, reportName: 'بيانات زيارة الطفل');
        await mpg.generatePdf(Get.context!);
        isLoading(false);
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
      ApiExceptionWidgets().myUnknownExceptionAlert();
    } finally {
      isLoading(false);
    }
  }
}
