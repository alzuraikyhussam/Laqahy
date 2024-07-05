import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/center_order_model.dart';
import 'package:laqahy/models/office_order_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/services/api/api_exception_widgets.dart';

class OrdersController extends GetxController {
  @override
  void onInit() async {
    officeId = await sdc.storageService.getOfficeId();
    sdc.fetchVaccines();
    super.onInit();
  }

  StaticDataController sdc = Get.find<StaticDataController>();

  int? officeId;

  RxString orderTapChange = 'add'.obs;
  var isIncomingLoading = false.obs;
  var incomingOrders = <CenterOrder>[].obs;
  var fetchIncomingOrdersFuture = Future<void>.value().obs;

  var isOutgoingLoading = false.obs;
  var outgoingOrders = <OfficeOrder>[].obs;
  var fetchOutgoingOrdersFuture = Future<void>.value().obs;

  var isInDeliveryLoading = false.obs;
  var inDeliveryOrders = <OfficeOrder>[].obs;
  var fetchInDeliveryOrdersFuture = Future<void>.value().obs;

  var isDeliveredLoading = false.obs;
  var deliveredOrders = <CenterOrder>[].obs;
  var fetchDeliveredOrdersFuture = Future<void>.value().obs;

  var isCancelledLoading = false.obs;
  var cancelledOrders = <OfficeOrder>[].obs;
  var fetchCancelledOrdersFuture = Future<void>.value().obs;

  var isApprovalLoading = false.obs;
  var isRejectLoading = false.obs;
  var isUndoLoading = false.obs;

  var isAddLoading = false.obs;

  GlobalKey<FormState> approvalAlertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> rejectAlertFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addOrderFormKey = GlobalKey<FormState>();
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
      final order = OfficeOrder(
        officeId: officeId,
        vaccineTypeId: sdc.selectedVaccine.value!.vaccineTypeId,
        quantity: int.tryParse(quantityController.text),
        officeNoteData: notesController.text,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addOrder),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 201) {
        clearTextFields();
        ApiExceptionWidgets().myAddedDataSuccessAlert();

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
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> fetchIncomingOrders() async {
    fetchIncomingOrdersFuture.value = Future<void>(() async {
      try {
        isIncomingLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getIncomingOrders}/$officeId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isIncomingLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          incomingOrders.value =
              jsonData.map((e) => CenterOrder.fromJson(e)).toList();
        } else {
          isIncomingLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          print(response.body);
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

  Future<void> fetchOutgoingOrders() async {
    fetchOutgoingOrdersFuture.value = Future<void>(() async {
      try {
        isOutgoingLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getOutgoingOrders}/$officeId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isOutgoingLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          outgoingOrders.value =
              jsonData.map((e) => OfficeOrder.fromJson(e)).toList();
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
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
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
          Uri.parse('${ApiEndpoints.getInDeliveryOrders}/$officeId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isInDeliveryLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          inDeliveryOrders.value =
              jsonData.map((e) => OfficeOrder.fromJson(e)).toList();
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
          Uri.parse('${ApiEndpoints.getDeliveredOrders}/$officeId'),
          headers: {
            'content-Type': 'application/json',
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
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
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
          Uri.parse('${ApiEndpoints.getCancelledOrders}/$officeId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isCancelledLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          cancelledOrders.value =
              jsonData.map((e) => OfficeOrder.fromJson(e)).toList();
        } else {
          isCancelledLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isCancelledLoading(false);
        ApiExceptionWidgets().mySocketExceptionAlert();
      } catch (e) {
        isCancelledLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isCancelledLoading(false);
      }
    });
  }

  Future<void> confirmCenterOrder(int id) async {
    isApprovalLoading(true);
    final order = CenterOrder(
      officeNoteData: notesController.text,
      quantity: int.tryParse(quantityController.text)!,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.confirmCenterOrder}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['quantity'] = order.quantity.toString();
      request.fields['office_note_data'] = order.officeNoteData.toString();

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
        await fetchOutgoingOrders();
        await fetchInDeliveryOrders();
        await fetchDeliveredOrders();
        await fetchCancelledOrders();

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

  Future<void> confirmDeliveredOrder({required int orderId}) async {
    ApiExceptionWidgets().myOrderAlert(
      title: 'تأكيــد',
      description:
          'لا يمكن التراجع عن هذه العملية، هل انت متأكد من استلام هذا الطلب؟',
      btnLabel: 'تأكيــد',
      imageUrl: 'assets/images/success.json',
      onCancelPressed: () {
        Get.back();
      },
      onPressed: () async {
        isApprovalLoading(true);

        final order = OfficeOrder(
          officeId: officeId,
          id: orderId,
        );
        try {
          var request = http.MultipartRequest(
              'POST', Uri.parse(ApiEndpoints.confirmDeliveredOrder));
          request.fields['_method'] = 'PATCH';
          request.fields['order_id'] = order.id.toString();
          request.fields['office_id'] = order.officeId.toString();

          var response = await request.send();

          if (response.statusCode == 200) {
            await fetchInDeliveryOrders();
            await fetchIncomingOrders();
            await fetchOutgoingOrders();
            await fetchDeliveredOrders();
            await fetchCancelledOrders();
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
          ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
          return;
        } finally {
          isApprovalLoading(false);
        }
      },
    );
  }

  Future<void> rejectCenterOrder(int id) async {
    isRejectLoading(true);
    final order = CenterOrder(
      officeNoteData: notesController.text,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.rejectCenterOrder}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['office_note_data'] = order.officeNoteData.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        ApiExceptionWidgets().myOrderAlert(
          title: 'تم الرفـض بنجاح',
          description: 'لقد تمت عملية الرفض بنجاح',
        );
        await fetchIncomingOrders();
        await fetchInDeliveryOrders();
        await fetchDeliveredOrders();
        await fetchCancelledOrders();
        isRejectLoading(false);
        return;
      } else {
        isRejectLoading(false);
        print(await response.stream.bytesToString());
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
}
