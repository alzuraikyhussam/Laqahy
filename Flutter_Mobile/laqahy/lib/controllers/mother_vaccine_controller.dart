import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/mother_vaccine_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';

class MotherVaccineController extends GetxController {
  StaticDataController sdc = Get.put(StaticDataController());
  @override
  void onInit() {
    motherId = sdc.userLoggedData.first.user.id;
    super.onInit();
  }

  int? motherId;

  var index = 0.obs;

  var isLoading = true.obs;
  var errorMsg = ''.obs;

  var motherVaccine = <MotherDosage>[
    MotherDosage(
      levelTitle: 'الأساسية',
      dosageCount: 0,
      dosageTakenCount: 0,
    ),
    MotherDosage(
      levelTitle: 'التنشيطية',
      dosageCount: 0,
      dosageTakenCount: 0,
    ),
  ].obs;

  Future<void> fetchMotherDosageDataTable() async {
    errorMsg('');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${ApiEndpoints.getMotherDosage}/$motherId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        Map<String, dynamic> data = jsonData['data'];
        List dosageCount = data['dosage_count'];

        motherVaccine[0].dosageCount = dosageCount[0]['dosage_type_count'];
        motherVaccine[1].dosageCount = dosageCount[1]['dosage_type_count'];

        motherVaccine[0].dosageTakenCount = data['basic_dosage_taken_count'];
        motherVaccine[1].dosageTakenCount =
            data['refresher_dosage_taken_count'];

        isLoading(false);
        return;
      } else {
        isLoading(false);
        errorMsg('فشل في تحميل البيانات\n${response.statusCode}');

        print(response.body);
      }
    } on SocketException catch (_) {
      isLoading(false);
      errorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isLoading(false);
      errorMsg('خطأ غير متوقع\n${e.toString()}');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
