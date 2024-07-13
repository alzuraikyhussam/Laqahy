import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/models/child_data_model.dart';
import 'package:laqahy/models/child_vaccine_dosage_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ChildVaccineController extends GetxController {
  @override
  void onInit() async {
    await fetchChildVaccineDataTable(1);
    super.onInit();
  }

  var isLoading = true.obs;
  var errorMsg = ''.obs;
  var childData = ChildData().obs;
  var childVaccines = <ChildVaccineDosage>[].obs;

  Future<void> fetchChildVaccineDataTable(int childId) async {
    errorMsg('');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${ApiEndpoints.getChildVaccines}/$childId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        childData.value = ChildData.fromJson(data['child_data']);
        var details = data['vaccine_dosage_details'] as List;
        childVaccines.value = details
            .map((detail) => ChildVaccineDosage.fromJson(detail))
            .toList();

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
      errorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
