import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ApprovalCenterOrderAlert extends StatefulWidget {
  ApprovalCenterOrderAlert(
      {super.key, required this.orderId, required this.quantity});

  int orderId;
  int quantity;

  @override
  State<ApprovalCenterOrderAlert> createState() =>
      _ApprovalCenterOrderAlertState();
}

class _ApprovalCenterOrderAlertState extends State<ApprovalCenterOrderAlert> {
  OrdersController oc = Get.put(OrdersController());

  @override
  void initState() {
    oc.clearTextFields();
    oc.quantityController.text = widget.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: oc.approvalAlertFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 320,
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myAppBarLogo(
                        width: 250,
                      ),
                    ],
                  ),
                ),
                Text(
                  'الموافقــة على الطلــب',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                const SizedBox(
                  height: 20,
                ),
                myTextField(
                  controller: oc.quantityController,
                  validator: oc.qtyValidator,
                  prefixIcon: Icons.numbers,
                  hintText: 'تحديد الكمية',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  validator: oc.notesValidator,
                  controller: oc.notesController,
                  maxLines: 2,
                  maxLength: 150,
                  heightFactor: 1.8,
                  prefixIcon: Icons.message_outlined,
                  hintText: 'ملاحظات',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return oc.isApprovalLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: oc.isApprovalLoading.value
                        ? null
                        : () async {
                            if (oc.approvalAlertFormKey.currentState!
                                .validate()) {
                              await oc.approvalCenterOrder(
                                  orderId: widget.orderId);
                            }
                          },
                    width: 150,
                    text: 'موافــق',
                    textStyle: MyTextStyles.font16WhiteBold,
                  );
          }),
          const SizedBox(
            width: 5,
          ),
          myButton(
            width: 150,
            onPressed: () {
              Get.back();
            },
            text: 'إلـغــاء الأمـــر',
            textStyle: MyTextStyles.font16WhiteBold,
            backgroundColor: MyColors.greyColor,
          ),
        ],
      ),
    );
  }
}
