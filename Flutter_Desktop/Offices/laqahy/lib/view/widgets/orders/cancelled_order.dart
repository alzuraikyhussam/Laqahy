import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CancelledOrder extends StatefulWidget {
  const CancelledOrder({super.key});

  @override
  State<CancelledOrder> createState() => _CancelledOrderState();
}

class _CancelledOrderState extends State<CancelledOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchCancelledOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchCancelledOrders();
                }),
              );
            } else {
              if (oc.cancelledOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات ملغيـــة',
                  onPressedRefresh: () {
                    oc.fetchCancelledOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.cancelledOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'cancelled',
                      id: oc.cancelledOrders[index].id!,
                      centerName: oc.cancelledOrders[index].officeName!,
                      vaccineType: oc.cancelledOrders[index].vaccineType!,
                      quantity: oc.cancelledOrders[index].quantity!,
                      note: oc.cancelledOrders[index].ministryNoteData!,
                      date: parsedDate,
                    );
                  },
                  itemCount: oc.cancelledOrders.length,
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
