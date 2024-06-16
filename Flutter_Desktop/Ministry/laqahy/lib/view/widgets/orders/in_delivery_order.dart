import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class InDeliveryOrder extends StatefulWidget {
  const InDeliveryOrder({super.key});

  @override
  State<InDeliveryOrder> createState() => _InDeliveryOrderState();
}

class _InDeliveryOrderState extends State<InDeliveryOrder> {
  OrdersController olc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: olc.fetchInDeliveryOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiException().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  olc.fetchInDeliveryOrders();
                }),
              );
            } else {
              if (olc.inDeliveryOrders.isEmpty) {
                return ApiException().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات قيـد التسليــم',
                  onPressedRefresh: () {
                    olc.fetchInDeliveryOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(olc.inDeliveryOrders[index].updatedAt!);
                    return myOrdersItem(
                      date: parsedDate,
                      orderState: 'in_delivery',
                      centerName: olc.inDeliveryOrders[index].officeName!,
                      vaccineType: olc.inDeliveryOrders[index].vaccineType!,
                      quantity: olc.inDeliveryOrders[index].quantity!,
                      note: olc.inDeliveryOrders[index].ministryNoteData!,
                    );
                  },
                  itemCount: olc.inDeliveryOrders.length,
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
