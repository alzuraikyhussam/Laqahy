import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/child_vaccine_model.dart';
import 'package:laqahy/models/child_vaccine_dosage_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/view/screens/child_vaccines/child_vaccine.dart';

class ChildVaccineController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  var isLoading = false.obs;
  var errorMsg = ''.obs;
  var childData = ChildVaccine().obs;
  var childVaccines = <ChildVaccineDosage>[].obs;

  Future<void> fetchChildVaccineDataTable(int childId) async {
    errorMsg('');
    try {
      isLoading(true);
      sanctumToken = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse('${ApiEndpoints.getChildVaccines}/$childId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        childData.value = ChildVaccine.fromJson(data['child_data']);
        var details = data['vaccine_dosage_details'] as List;
        childVaccines.value = details
            .map((detail) => ChildVaccineDosage.fromJson(detail))
            .toList();
        Get.back();
        Get.to(const ChildVaccineScreen());

        isLoading(false);
        return;
      } else {
        isLoading(false);
        errorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isLoading(false);
      errorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isLoading(false);
      errorMsg('خطأ غير متوقع');
    } finally {
      isLoading(false);
    }
  }
}
