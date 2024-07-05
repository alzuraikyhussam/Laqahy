import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class IncomingOrder extends StatefulWidget {
  const IncomingOrder({super.key});

  @override
  State<IncomingOrder> createState() => _IncomingOrderState();
}

class _IncomingOrderState extends State<IncomingOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchIncomingOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchIncomingOrders();
                }),
              );
            } else {
              if (oc.incomingOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات واردة',
                  onPressedRefresh: () {
                    oc.fetchIncomingOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.incomingOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'incoming',
                      id: oc.incomingOrders[index].id!,
                      centerName: oc.incomingOrders[index].centerName!,
                      vaccineType: oc.incomingOrders[index].vaccineType!,
                      quantity: oc.incomingOrders[index].quantity!,
                      note: oc.incomingOrders[index].centerNoteData!,
                      date: parsedDate,
                    );
                  },
                  itemCount: oc.incomingOrders.length,
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
