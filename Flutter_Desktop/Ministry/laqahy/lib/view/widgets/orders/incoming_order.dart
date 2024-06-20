import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/orders/approval_order_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/orders/reject_confirm_alert.dart';

class IncomingOrder extends StatefulWidget {
  const IncomingOrder({super.key});

  @override
  State<IncomingOrder> createState() => _IncomingOrderState();
}

class _IncomingOrderState extends State<IncomingOrder> {
  OrdersController olc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: olc.fetchIncomingOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  olc.fetchIncomingOrders();
                }),
              );
            } else {
              if (olc.incomingOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات واردة',
                  onPressedRefresh: () {
                    olc.fetchIncomingOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(olc.incomingOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'incoming',
                      id: olc.incomingOrders[index].id!,
                      centerName: olc.incomingOrders[index].officeName!,
                      vaccineType: olc.incomingOrders[index].vaccineType!,
                      quantity: olc.incomingOrders[index].quantity!,
                      note: olc.incomingOrders[index].officeNoteData!,
                      date: parsedDate,
                    );
                  },
                  itemCount: olc.incomingOrders.length,
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
