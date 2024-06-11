import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/vaccine_quantity_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception.dart';

class VaccineController extends GetxController {
  var vaccines = <VaccineQuantity>[].obs;
  var fetchDataFuture = Future<void>.value().obs;
  var isLoading = false.obs;
  var isAddLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    fetchVaccines();
  }

  GlobalKey<FormState> addQtyVaccineFormKey = GlobalKey<FormState>();

  TextEditingController sourceController = TextEditingController();
  String? sourceValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال اسم الجهة المانحة ';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يمكن ادخال ارقام او رموز';
    }
    return null;
  }

  /////////////
  TextEditingController qtyController = TextEditingController();
  String? qtyValidator(value) {
    if (value.trim().isEmpty) {
      return 'يرجى ادخال الكمية';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    }
    return null;
  }

  void clearTextFormFields() {
    sourceController.clear();
    qtyController.clear();
  }

  Future<void> fetchVaccines() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getVaccines),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<VaccineQuantity> fetchedVaccine =
              jsonData.map((e) => VaccineQuantity.fromJson(e)).toList();
          vaccines.assignAll(fetchedVaccine);
        } else if (response.statusCode == 500) {
          isLoading(false);
          ApiException().myFetchDataExceptionAlert(response.statusCode);
        } else {
          isLoading(false);
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isLoading(false);
      }
    });
  }

  Future<void> addVaccineQty(int id) async {
    try {
      isAddLoading(true);
      final vaccineQty = VaccineQuantity(
        vaccineTypeId: id,
        donor: sourceController.text,
        quantity: int.tryParse(qtyController.text),
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addVaccineQuantity),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(vaccineQty.toJson()),
      );

      if (response.statusCode == 201) {
        isAddLoading(false);
        Get.back();
        await fetchVaccines();
        clearTextFormFields();
        ApiException().myAddedDataSuccessAlert();
        return;
      } else {
        isAddLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        print(response.body);
        return;
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }
}
