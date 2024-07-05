import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/models/order_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_widgets.dart';

class OrdersController extends GetxController {
  @override
  void onInit() {
    fetchIncomingOrders();
    super.onInit();
  }

  RxString orderTapChange = 'incoming'.obs;
  var isIncomingLoading = false.obs;
  var incomingOrders = <Order>[].obs;
  var fetchIncomingOrdersFuture = Future<void>.value().obs;

  var isInDeliveryLoading = false.obs;
  var inDeliveryOrders = <Order>[].obs;
  var fetchInDeliveryOrdersFuture = Future<void>.value().obs;

  var isDeliveredLoading = false.obs;
  var deliveredOrders = <Order>[].obs;
  var fetchDeliveredOrdersFuture = Future<void>.value().obs;

  var isRejectedOrdersLoading = false.obs;
  var rejectedOrders = <Order>[].obs;
  var fetchRejectedOrdersFuture = Future<void>.value().obs;

  var isApprovalLoading = false.obs;
  var isRejectLoading = false.obs;
  var isUndoLoading = false.obs;
  GlobalKey<FormState> approvalAlertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> rejectAlertFormKey = GlobalKey<FormState>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController rejectReasonController = TextEditingController();

  onChangeOrder(String order) {
    orderTapChange.value = order;
  }

  clearTextFields() {
    quantityController.clear();
    notesController.clear();
    rejectReasonController.clear();
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

  Future<void> fetchIncomingOrders() async {
    fetchIncomingOrdersFuture.value = Future<void>(() async {
      try {
        isIncomingLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getIncomingOrders),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isIncomingLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          incomingOrders.value =
              jsonData.map((e) => Order.fromJson(e)).toList();
        } else {
          isIncomingLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isIncomingLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isIncomingLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isIncomingLoading(false);
      }
    });
  }

  Future<void> fetchInDeliveryOrders() async {
    fetchInDeliveryOrdersFuture.value = Future<void>(() async {
      try {
        isInDeliveryLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getInDeliveryOrders),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isInDeliveryLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          inDeliveryOrders.value =
              jsonData.map((e) => Order.fromJson(e)).toList();
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
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
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
          Uri.parse(ApiEndpoints.getDeliveredOrders),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isDeliveredLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          deliveredOrders.value =
              jsonData.map((e) => Order.fromJson(e)).toList();
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
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
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
          Uri.parse(ApiEndpoints.getRejectedOrders),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isRejectedOrdersLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          rejectedOrders.value =
              jsonData.map((e) => Order.fromJson(e)).toList();
        } else {
          isRejectedOrdersLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isRejectedOrdersLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isRejectedOrdersLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isRejectedOrdersLoading(false);
      }
    });
  }

  Future<void> approvalOrder(int id) async {
    isApprovalLoading(true);
    print(quantityController.text);
    final order = Order(
      ministryNoteData: notesController.text,
      quantity: int.tryParse(quantityController.text),
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.approvalOrder}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['quantity'] = order.quantity.toString();
      request.fields['ministry_note_data'] = order.ministryNoteData.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        var quantity = data['quantity'];

        Get.back();
        ApiExceptionWidgets().myOrderWithQuantityAlert(
          quantity: quantity,
          title: 'تمت الموافقة بنجاح',
          description: 'لقد تمت عملية الموافقة بنجاح',
        );
        await fetchIncomingOrders();

        isApprovalLoading(false);

        return;
      } else if (response.statusCode == 401) {
        var data = json.decode(await response.stream.bytesToString());
        var quantity = data['quantity'];
        isApprovalLoading(false);
        ApiExceptionWidgets().myVaccineQtyNotEnoughAlert(quantity: quantity);
        return;
      } else {
        isApprovalLoading(false);
        print(await response.stream.bytesToString());
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
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isApprovalLoading(false);
    }
  }

  Future<void> rejectOrder(int id) async {
    isRejectLoading(true);
    final order = Order(
      ministryNoteData: rejectReasonController.text,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.rejectOrder}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['ministry_note_data'] = order.ministryNoteData.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        ApiExceptionWidgets().myOrderAlert(
          title: 'تم الرفـض بنجاح',
          description: 'لقد تمت عملية الرفض بنجاح',
        );
        await fetchIncomingOrders();

        isRejectLoading(false);
        return;
      } else {
        print(await response.stream.bytesToString());

        isRejectLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isRejectLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isRejectLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isRejectLoading(false);
    }
  }

  Future<void> undoRejectedOrder(int id) async {
    isUndoLoading(true);

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.undoRejectedOrder}/$id'));
      request.fields['_method'] = 'PATCH';

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        ApiExceptionWidgets().myOrderAlert(
          title: 'تم التراجع بنجاح',
          description: 'لقد تمت عملية التراجع بنجاح',
        );

        await fetchRejectedOrders();
        isUndoLoading(false);
        return;
      } else {
        print(await response.stream.bytesToString());

        isUndoLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isUndoLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUndoLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUndoLoading(false);
    }
  }
}
