import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class OutgoingOrder extends StatefulWidget {
  const OutgoingOrder({super.key});

  @override
  State<OutgoingOrder> createState() => _OutgoingOrderState();
}

class _OutgoingOrderState extends State<OutgoingOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchOutgoingOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchOutgoingOrders();
                }),
              );
            } else {
              if (oc.outgoingOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات صـــادرة',
                  onPressedRefresh: () {
                    oc.fetchOutgoingOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.outgoingOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'outgoing',
                      id: oc.outgoingOrders[index].id!,
                      centerName: oc.outgoingOrders[index].centerName!,
                      vaccineType: oc.outgoingOrders[index].vaccineType!,
                      quantity: oc.outgoingOrders[index].quantity!,
                      note: oc.outgoingOrders[index].centerNoteData!,
                      date: parsedDate,
                    );
                  },
                  itemCount: oc.outgoingOrders.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
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
