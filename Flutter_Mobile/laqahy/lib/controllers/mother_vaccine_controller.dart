import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/mother_vaccine_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';

class MotherVaccineController extends GetxController {

StaticDataController sdc = Get.find<StaticDataController>();
  @override
  void onInit()  {
   motherId=sdc.userLoggedData.first.id;
    fetchMotherVaccineDataTable();
    super.onInit();
  }

  int? motherId ;

  var fetchDataFuture = Future<void>.value().obs;

  var isLoading = true.obs;
  var errorMsg = ''.obs;



  var motherVaccine = <MotherVaccine>[
    MotherVaccine(
      stageTitle: 'الجرعات الأساسية',
      dosageCount: 0,
      dosageTakenCount: 0,
    ),
    MotherVaccine(
      stageTitle: 'الجرعات التنشيطية',
      dosageCount: 0,
      dosageTakenCount: 0,
    ),
  ].obs;



   Future<void> fetchMotherVaccineDataTable() async {

    errorMsg('');
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        var response = await http.get(
          Uri.parse('${ApiEndpoints.getMotherVaccine}/$motherId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = jsonDecode(response.body);
          Map<String, dynamic> data = jsonData['data'];

          motherVaccine[0].dosageCount = data['dosage_count'];
          motherVaccine[0].dosageTakenCount = data['dosage_taken_count'];
          motherVaccine[1].dosageCount = data['dosage_count'];
          motherVaccine[1].dosageTakenCount = data['dosage_taken_count'];
          
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
      } finally {
        isLoading(false);
      }
    });
  }

}
