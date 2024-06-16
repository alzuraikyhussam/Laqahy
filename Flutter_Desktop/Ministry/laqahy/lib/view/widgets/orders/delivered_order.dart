import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class DeliveredOrder extends StatefulWidget {
  const DeliveredOrder({super.key});

  @override
  State<DeliveredOrder> createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  OrdersController olc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: olc.fetchDeliveredOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiException().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  olc.fetchDeliveredOrders();
                }),
              );
            } else {
              if (olc.deliveredOrders.isEmpty) {
                return ApiException().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات تـم تسليمهــا',
                  onPressedRefresh: () {
                    olc.fetchDeliveredOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(olc.deliveredOrders[index].deliveryDate!);
                    return myOrdersItem(
                      date: parsedDate,
                      centerName: olc.deliveredOrders[index].officeName!,
                      vaccineType: olc.deliveredOrders[index].vaccineType!,
                      quantity: olc.deliveredOrders[index].quantity!,
                      note: olc.deliveredOrders[index].ministryNoteData!,
                      // content: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Expanded(
                      //           flex: 2,
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'اسم المركز الصحي:',
                      //                 style: MyTextStyles.font16PrimaryBold,
                      //               ),
                      //               SizedBox(
                      //                 width: 5,
                      //               ),
                      //               Text(
                      //                 'مركز المظفر',
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 1,
                      //                 style: MyTextStyles.font16BlackBold,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           flex: 2,
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'اسم اللقــاح:',
                      //                 style: MyTextStyles.font16PrimaryBold,
                      //               ),
                      //               SizedBox(
                      //                 width: 5,
                      //               ),
                      //               Text(
                      //                 'شلل الاطفال',
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 1,
                      //                 style: MyTextStyles.font16BlackBold,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'الكميــة:',
                      //                 style: MyTextStyles.font16PrimaryBold,
                      //               ),
                      //               SizedBox(
                      //                 width: 5,
                      //               ),
                      //               Text(
                      //                 '200',
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 1,
                      //                 style: MyTextStyles.font16BlackBold,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                      //     Expanded(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             'ملاحظــة الـوزارة:',
                      //             overflow: TextOverflow.ellipsis,
                      //             style: MyTextStyles.font16PrimaryBold,
                      //           ),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           Expanded(
                      //             child: Text(
                      //               'lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll------------------------------------------------------------------------------------------------------------------------------------------------------llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll',
                      //               overflow: TextOverflow.ellipsis,
                      //               maxLines: 2,
                      //               style: MyTextStyles.font16BlackBold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    );
                  },
                  itemCount: olc.deliveredOrders.length,
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
