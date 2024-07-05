import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class RejectedOrder extends StatefulWidget {
  const RejectedOrder({super.key});

  @override
  State<RejectedOrder> createState() => _RejectedOrderState();
}

class _RejectedOrderState extends State<RejectedOrder> {
  OrdersController olc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Obx(() {
        return FutureBuilder(
          future: olc.fetchRejectedOrdersFuture.value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: myLoadingIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () {
                  olc.fetchRejectedOrders();
                }),
              );
            } else {
              if (olc.rejectedOrders.isEmpty) {
                return ApiExceptionWidgets().myDataNotFound(
                  text: 'لـم يتـــم العثــور على طلبــات مرفـوضــة',
                  onPressedRefresh: () {
                    olc.fetchRejectedOrders();
                  },
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var parsedDate = DateFormat('EEEE dd-MM-yyyy hh:mm')
                        .format(olc.rejectedOrders[index].orderDate!);
                    return myOrdersItem(
                      orderState: 'rejected',
                      id: olc.rejectedOrders[index].id!,
                      centerName: olc.rejectedOrders[index].officeName!,
                      vaccineType: olc.rejectedOrders[index].vaccineType!,
                      quantity: olc.rejectedOrders[index].quantity!,
                      note: olc.rejectedOrders[index].ministryNoteData!,
                      date: parsedDate,

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
                      //             'سـبب الـرفــض:',
                      //             style: MyTextStyles.font16RedBold,
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
                  itemCount: olc.rejectedOrders.length,
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
