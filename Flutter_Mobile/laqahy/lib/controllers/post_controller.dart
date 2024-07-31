import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/post_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_widgets.dart';

class PostController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  onInit() async {
    sanctumToken = await storage.read(key: 'token');
    fetchPosts();
    super.onInit();
  }

  var isLoading = true.obs;
  var posts = <Post>[].obs;
  var fetchDataFuture = Future<void>.value().obs;

  Future<void> fetchPosts() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getPosts),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<Post> fetchedPost =
              jsonData.map((e) => Post.fromJson(e)).toList();
          posts.assignAll(fetchedPost);
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
