import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/center_order_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_widgets.dart';

class OrdersController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? sanctumToken;

  @override
  void onInit() async {
    sanctumToken = await storage.read(key: 'token');
    centerId = await sdc.storageService.getCenterId();
    await sdc.fetchVaccines();
    super.onInit();
  }

  int? centerId;

  RxString orderTapChange = 'add'.obs;

  var isOutgoingLoading = true.obs;
  var outgoingOrders = <CenterOrder>[].obs;
  var fetchOutgoingOrdersFuture = Future<void>.value().obs;

  var isInDeliveryLoading = true.obs;
  var inDeliveryOrders = <CenterOrder>[].obs;
  var fetchInDeliveryOrdersFuture = Future<void>.value().obs;

  var isDeliveredLoading = true.obs;
  var deliveredOrders = <CenterOrder>[].obs;
  var fetchDeliveredOrdersFuture = Future<void>.value().obs;

  var isRejectedOrdersLoading = true.obs;
  var rejectedOrders = <CenterOrder>[].obs;
  var fetchRejectedOrdersFuture = Future<void>.value().obs;

  var isApprovalLoading = false.obs;

  var isAddLoading = false.obs;

  GlobalKey<FormState> approvalAlertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> rejectAlertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addOrderFormKey = GlobalKey<FormState>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  onChangedTapOrder(String order) {
    orderTapChange.value = order;
  }

  clearTextFields() {
    quantityController.clear();
    notesController.clear();
    sdc.selectedVaccine.value = null;
  }

  String? qtyValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الكمية';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (int.tryParse(value)! <= 0) {
      return 'يجب ادخال كمية اكبر من الصفر';
    }
    return null;
  }

  String? notesValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال نص الملاحظة ';
    }
    return null;
  }

  String? rejectReasonValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال نص سبب الرفض ';
    }
    return null;
  }

  Future<void> addOrder() async {
    try {
      isAddLoading(true);
      final order = CenterOrder(
        centerId: centerId,
        vaccineTypeId: sdc.selectedVaccine.value!.id,
        quantity: int.tryParse(quantityController.text),
        centerNoteData: notesController.text,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addOrder),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sanctumToken',
        },
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 201) {
        await fetchOutgoingOrders();

        await ApiExceptionWidgets().myAddedDataSuccessAlert();

        onChangedTapOrder('outgoing');

        clearTextFields();

        isAddLoading(false);

        return;
      } else {
        isAddLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert();
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> fetchOutgoingOrders() async {
    fetchOutgoingOrdersFuture.value = Future<void>(() async {
      try {
        isOutgoingLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getOutgoingOrders}/$centerId'),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isOutgoingLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          outgoingOrders.value =
              jsonData.map((e) => CenterOrder.fromJson(e)).toList();
        } else {
          isOutgoingLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isOutgoingLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isOutgoingLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      } finally {
        isOutgoingLoading(false);
      }
    });
  }

  Future<void> fetchInDeliveryOrders() async {
    fetchInDeliveryOrdersFuture.value = Future<void>(() async {
      try {
        isInDeliveryLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getInDeliveryOrders}/$centerId'),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isInDeliveryLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          inDeliveryOrders.value =
              jsonData.map((e) => CenterOrder.fromJson(e)).toList();
        } else {
          isInDeliveryLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isInDeliveryLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isInDeliveryLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      } finally {
        isInDeliveryLoading(false);
      }
    });
  }

  Future<void> fetchDeliveredOrders() async {
    fetchDeliveredOrdersFuture.value = Future<void>(() async {
      try {
        isDeliveredLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getDeliveredOrders}/$centerId'),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isDeliveredLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          deliveredOrders.value =
              jsonData.map((e) => CenterOrder.fromJson(e)).toList();
        } else {
          isDeliveredLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isDeliveredLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isDeliveredLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      } finally {
        isDeliveredLoading(false);
      }
    });
  }

  Future<void> fetchRejectedOrders() async {
    fetchRejectedOrdersFuture.value = Future<void>(() async {
      try {
        isRejectedOrdersLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getRejectedOrders}/$centerId'),
          headers: {
            'content-Type': 'application/json',
            'Authorization': 'Bearer $sanctumToken',
          },
        );
        if (response.statusCode == 200) {
          isRejectedOrdersLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          rejectedOrders.value =
              jsonData.map((e) => CenterOrder.fromJson(e)).toList();
        } else {
          isRejectedOrdersLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          print(response.body);
        }
      } on SocketException catch (_) {
        isRejectedOrdersLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isRejectedOrdersLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      } finally {
        isRejectedOrdersLoading(false);
      }
    });
  }

  Future<void> receivingOrderConfirm({required int orderId}) async {
    isApprovalLoading(true);

    final order = CenterOrder(
      centerId: centerId,
      id: orderId,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiEndpoints.receivingOrderConfirm));
      // Add headers to the request
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $sanctumToken';

      request.fields['_method'] = 'PATCH';
      request.fields['order_id'] = order.id.toString();
      request.fields['healthy_center_id'] = order.centerId.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        ApiExceptionWidgets().myOrderAlert(
          title: 'تم الاستلام بنجاح',
          description: 'لقد تمت عملية استلام الطلب بنجاح',
        );
        await fetchInDeliveryOrders();

        isApprovalLoading(false);
        return;
      } else {
        print(await response.stream.bytesToString());

        isApprovalLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isApprovalLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isApprovalLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert();
      return;
    } finally {
      isApprovalLoading(false);
    }
  }
}
