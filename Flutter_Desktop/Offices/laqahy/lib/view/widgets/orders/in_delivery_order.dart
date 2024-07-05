import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class InDeliveryOrder extends StatefulWidget {
  const InDeliveryOrder({super.key});

  @override
  State<InDeliveryOrder> createState() => _InDeliveryOrderState();
}

class _InDeliveryOrderState extends State<InDeliveryOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchInDeliveryOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchInDeliveryOrders();
                }),
              );
            } else {
              if (oc.inDeliveryOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات قيـد التسليــم',
                  onPressedRefresh: () {
                    oc.fetchInDeliveryOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.inDeliveryOrders[index].updatedAt!);
                    return myOrdersItem(
                      date: parsedDate,
                      height: 280,
                      orderState: 'in_delivery',
                      officeName: oc.inDeliveryOrders[index].officeName!,
                      vaccineType: oc.inDeliveryOrders[index].vaccineType!,
                      quantity: oc.inDeliveryOrders[index].quantity!,
                      note: oc.inDeliveryOrders[index].ministryNoteData!,
                    );
                  },
                  itemCount: oc.inDeliveryOrders.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                );
              }
            }
          },
        );
      }),
    );
  }
}
