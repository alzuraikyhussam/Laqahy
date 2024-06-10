import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/user_models.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception.dart';

class UserController extends GetxController {
  var users = [].obs;
  var filteredUsers = [].obs;
  var isLoading = false.obs;
  TextEditingController userSearchController = TextEditingController();

  @override
  onInit() {
    fetchUsers();
    super.onInit();
  }

  void filterUsers(String keyword) {
    filteredUsers.value = users.where((user) {
      return user.name
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          user.username
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getUsers),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        users.value = jsonData.map((e) => User.fromJson(e)).toList();

        filteredUsers.assignAll(users);
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
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
