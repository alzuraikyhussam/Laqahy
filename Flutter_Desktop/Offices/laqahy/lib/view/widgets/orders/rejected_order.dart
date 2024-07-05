import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class RejectedOrder extends StatefulWidget {
  const RejectedOrder({super.key});

  @override
  State<RejectedOrder> createState() => _RejectedOrderState();
}

class _RejectedOrderState extends State<RejectedOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchRejectedOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchRejectedOrders();
                }),
              );
            } else {
              if (oc.rejectedOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات مرفـوضــة',
                  onPressedRefresh: () {
                    oc.fetchRejectedOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.rejectedOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'rejected',
                      id: oc.rejectedOrders[index].id!,
                      centerName: oc.rejectedOrders[index].officeName!,
                      vaccineType: oc.rejectedOrders[index].vaccineType!,
                      quantity: oc.rejectedOrders[index].quantity!,
                      note: oc.rejectedOrders[index].ministryNoteData!,
                      date: parsedDate,
                    );
                  },
                  itemCount: oc.rejectedOrders.length,
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
