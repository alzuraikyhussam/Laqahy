import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/notifications_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class NotificationsController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  onInit() async {
    sanctumToken = await storage.read(key: 'token');
    fetchNotifications();
    super.onInit();
  }

  StaticDataController sdc = Get.put(StaticDataController());

  var isLoading = true.obs;
  var notifications = <Notifications>[].obs;
  var fetchDataFuture = Future<void>.value().obs;

  Future<void> fetchNotifications() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        int motherId = sdc.userLoggedData.first.user.id!;
        isLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getNotifications}/$motherId'),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<Notifications> fetchedData =
              jsonData.map((e) => Notifications.fromJson(e)).toList();
          notifications.assignAll(fetchedData);
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
    });
  }
}
