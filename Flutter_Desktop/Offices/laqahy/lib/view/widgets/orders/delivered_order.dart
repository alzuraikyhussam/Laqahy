import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class DeliveredOrder extends StatefulWidget {
  const DeliveredOrder({super.key});

  @override
  State<DeliveredOrder> createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: oc.fetchDeliveredOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  oc.fetchDeliveredOrders();
                }),
              );
            } else {
              if (oc.deliveredOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات تـم تسليمهــا',
                  onPressedRefresh: () {
                    oc.fetchDeliveredOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(oc.deliveredOrders[index].deliveryDate!);
                    return myOrdersItem(
                      date: parsedDate,
                      centerName: oc.deliveredOrders[index].centerName!,
                      vaccineType: oc.deliveredOrders[index].vaccineType!,
                      quantity: oc.deliveredOrders[index].quantity!,
                      note: oc.deliveredOrders[index].officeNoteData!,
                    );
                  },
                  itemCount: oc.deliveredOrders.length,
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
