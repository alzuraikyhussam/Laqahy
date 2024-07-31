import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/home_card_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_endpoints.dart';

class HomeController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  void onInit() async {
    sanctumToken = await storage.read(key: 'token');
    officeId = await sdc.storageService.getOfficeId();
    fetchHomeCardItems();
    super.onInit();
  }

  int? officeId;

  var fetchDataFuture = Future<void>.value().obs;

  var isLoading = true.obs;
  var errorMsg = ''.obs;

  var homeCardItems = <HomeCardItem>[
    HomeCardItem(
      imagePath: 'assets/icons/emp-count.png',
      title: 'عدد المستخدمين',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/office.png',
      title: 'عدد المكاتب',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/building.png',
      title: 'عدد المراكز الصحية',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/women-count.png',
      title: 'عدد حالات الأمهات',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/children-count.png',
      title: 'عدد حالات الأطفال',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/vaccine.png',
      title: 'عدد اللقاحات',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/order-icon.png',
      title: 'عدد الطلبات المُسلَّمة',
      count: 0,
    ),
    HomeCardItem(
      imagePath: 'assets/icons/posts.png',
      title: 'عدد الإعلانات',
      count: 0,
    ),
  ].obs;

  Future<void> fetchHomeCardItems() async {
    errorMsg('');
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        var response = await http.get(
          Uri.parse('${ApiEndpoints.getTotalCount}/$officeId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = jsonDecode(response.body);
          Map<String, dynamic> data = jsonData['data'];

          homeCardItems[0].count = data['users_count'];
          homeCardItems[1].count = data['offices_count'];
          homeCardItems[2].count = data['centers_count'];
          homeCardItems[3].count = data['mothers_count'];
          homeCardItems[4].count = data['children_count'];
          homeCardItems[5].count = data['vaccines_count'];
          homeCardItems[6].count = data['orders_count'];
          homeCardItems[7].count = data['posts_count'];
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
        errorMsg('لقد حدث خطأ غير متوقع، الرجاء المحاولة مرة أخرى');
      } finally {
        isLoading(false);
      }
    });
  }
}
