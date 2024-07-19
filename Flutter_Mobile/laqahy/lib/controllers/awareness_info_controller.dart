import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:laqahy/models/awareness_info_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_widgets.dart';

class AwarenessInfoController extends GetxController {
  @override
  onInit() {
    fetchAwarenessInfo();
    super.onInit();
  }

  var isLoading = true.obs;
  var awarenessInfo = <AwarenessInformation>[].obs;
  var fetchDataFuture = Future<void>.value().obs;

  Future<void> fetchAwarenessInfo() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getAwarenessInfo),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<AwarenessInformation> fetchedData =
              jsonData.map((e) => AwarenessInformation.fromJson(e)).toList();
          awarenessInfo.assignAll(fetchedData);
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
        print(e);
      } finally {
        isLoading(false);
      }
    });
  }
}
