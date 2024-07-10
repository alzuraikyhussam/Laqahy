import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/home_card_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    fetchHomeCardItems();
    super.onInit();
  }

  StaticDataController sdc = Get.find<StaticDataController>();

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
      imagePath: 'assets/icons/order-icon.png',
      title: 'عدد الطلبات المُستلمة',
      count: 0,
    ),
  ].obs;

  Future<void> fetchHomeCardItems() async {
    errorMsg('');

    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);

        var centerId = await sdc.storageService.getCenterId();

        var response = await http.get(
          Uri.parse('${ApiEndpoints.getTotalCount}/$centerId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = jsonDecode(response.body);
          Map<String, dynamic> data = jsonData['data'];

          homeCardItems[0].count = data['users_count'];
          homeCardItems[1].count = data['mothers_count'];
          homeCardItems[2].count = data['children_count'];
          homeCardItems[3].count = data['orders_count'];

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
    });
  }
}
