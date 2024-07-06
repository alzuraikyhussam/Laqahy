import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ReceivingOrderConfirmAlert extends StatefulWidget {
  ReceivingOrderConfirmAlert({super.key, required this.orderId});

  int orderId;

  @override
  State<ReceivingOrderConfirmAlert> createState() =>
      _ReceivingOrderConfirmAlertState();
}

class _ReceivingOrderConfirmAlertState
    extends State<ReceivingOrderConfirmAlert> {
  OrdersController oc = Get.put(OrdersController());

  @override
  void initState() {
    oc.clearTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants().playErrorSound();
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        padding: const EdgeInsetsDirectional.only(
          top: 20,
        ),
        height: 280,
        width: 350,
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 150,
                width: Get.width,
                child: Lottie.asset(
                  'assets/images/warning.json',
                  alignment: Alignment.center,
                  // fit: BoxFit.cover,
                ),
                // Image.asset(
                //   widget.imageUrl,
                //   width: 130,
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تأكيــد اســتلام الطلـب',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'لا يمكنك التراجع عن هذه العملية، هل انت متأكد من استلام هذا الطلب؟',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyles.font16GreyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() {
          return oc.isApprovalLoading.value
              ? myLoadingIndicator(width: 150)
              : myButton(
                  onPressed: () async {
                    await oc.receivingOrderConfirm(orderId: widget.orderId);
                  },
                  backgroundColor: MyColors.primaryColor,
                  text: 'تأكيـــد',
                  textStyle: MyTextStyles.font16WhiteBold,
                  width: 150,
                );
        }),
        const SizedBox(
          width: 5,
        ),
        myButton(
          onPressed: () {
            Get.back();
          },
          backgroundColor: MyColors.greyColor,
          text: 'إلغــاء الأمــر',
          textStyle: MyTextStyles.font16WhiteBold,
          width: 150,
        ),
      ],
    );
  }
}
