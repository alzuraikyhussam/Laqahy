import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/models/order_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/orders/incoming_order.dart';

class OrdersController extends GetxController {
  @override
  void onInit() {
    fetchIncomingOrders();
    fetchInDeliveryOrders();
    fetchDeliveredOrders();
    fetchCancelledOrders();
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

  var isCancelledLoading = false.obs;
  var cancelledOrders = <Order>[].obs;
  var fetchCancelledOrdersFuture = Future<void>.value().obs;

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
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isIncomingLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isIncomingLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
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
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isInDeliveryLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isInDeliveryLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
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
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isDeliveredLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isDeliveredLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isDeliveredLoading(false);
      }
    });
  }

  Future<void> fetchCancelledOrders() async {
    fetchCancelledOrdersFuture.value = Future<void>(() async {
      try {
        isCancelledLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getCancelledOrders),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isCancelledLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          cancelledOrders.value =
              jsonData.map((e) => Order.fromJson(e)).toList();
        } else {
          isCancelledLoading(false);
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isCancelledLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isCancelledLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isCancelledLoading(false);
      }
    });
  }

  Future<void> transferOrderToInDelivery(int id) async {
    print(id);
    isApprovalLoading(true);
    final order = Order(
      ministryNoteData: notesController.text,
      quantity: int.tryParse(quantityController.text)!,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.transferOrderToInDelivery}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['quantity'] = order.quantity.toString();
      request.fields['ministry_note_data'] = order.ministryNoteData.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        var quantity = data['quantity'];
        await fetchIncomingOrders();
        await fetchInDeliveryOrders();
        await fetchDeliveredOrders();
        await fetchCancelledOrders();
        isApprovalLoading(false);
        Get.back();
        ApiException().myOrderWithQuantityAlert(
          quantity: quantity,
          title: 'تمت الموافقة بنجاح',
          description: 'لقد تمت عملية الموافقة بنجاح',
        );
        print(quantity);
        return;
      } else if (response.statusCode == 401) {
        var data = json.decode(await response.stream.bytesToString());
        var quantity = data['quantity'];
        isApprovalLoading(false);
        ApiException().myVaccineQtyNotEnoughAlert(quantity: quantity);
        return;
      } else {
        isApprovalLoading(false);
        print(await response.stream.bytesToString());
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isApprovalLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isApprovalLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isApprovalLoading(false);
    }
  }

  Future<void> transferOrderToCancelled(int id) async {
    print(id);
    isRejectLoading(true);
    final order = Order(
      ministryNoteData: rejectReasonController.text,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.transferOrderToCancelled}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['ministry_note_data'] = order.ministryNoteData.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        await fetchIncomingOrders();
        await fetchInDeliveryOrders();
        await fetchDeliveredOrders();
        await fetchCancelledOrders();
        isRejectLoading(false);
        Get.back();
        ApiException().myOrderAlert(
          title: 'تم الرفـض بنجاح',
          description: 'لقد تمت عملية الرفض بنجاح',
        );
        return;
      } else {
        print(await response.stream.bytesToString());

        isRejectLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isRejectLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isRejectLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isRejectLoading(false);
    }
  }

  Future<void> undoCancelledOrder(int id) async {
    isUndoLoading(true);

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.undoCancelled}/$id'));
      request.fields['_method'] = 'PATCH';

      var response = await request.send();

      if (response.statusCode == 200) {
        await fetchIncomingOrders();
        await fetchInDeliveryOrders();
        await fetchDeliveredOrders();
        await fetchCancelledOrders();
        isUndoLoading(false);
        Get.back();
        ApiException().myOrderAlert(
          title: 'تم التراجع بنجاح',
          description: 'لقد تمت عملية التراجع بنجاح',
        );
        return;
      } else {
        print(await response.stream.bytesToString());

        isUndoLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isUndoLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUndoLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUndoLoading(false);
    }
  }
}
