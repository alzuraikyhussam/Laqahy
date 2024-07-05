import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/vaccine_quantity_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class VaccineController extends GetxController {
  var vaccines = <VaccineQuantity>[].obs;
  var fetchDataFuture = Future<void>.value().obs;
  var filteredVaccines = [].obs;
  var isLoading = false.obs;

  StaticDataController sdc = Get.find<StaticDataController>();
  int? centerId;

  @override
  onInit() async {
    super.onInit();
    centerId = await sdc.storageService.getCenterId();
    fetchVaccinesQuantity();
  }

  /////////////

  Future<void> fetchVaccinesQuantity() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getVaccinesQuantity}/$centerId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          vaccines.value =
              jsonData.map((e) => VaccineQuantity.fromJson(e)).toList();
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
    });
  }
}
