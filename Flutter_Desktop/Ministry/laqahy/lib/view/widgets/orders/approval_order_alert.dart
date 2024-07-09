import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ApprovalOrderAlert extends StatefulWidget {
  ApprovalOrderAlert({super.key, required this.id, required this.quantity});

  int id;
  int quantity;

  @override
  State<ApprovalOrderAlert> createState() => _ApprovalOrderAlertState();
}

class _ApprovalOrderAlertState extends State<ApprovalOrderAlert> {
  OrdersController olc = Get.put(OrdersController());

  @override
  void initState() {
    olc.clearTextFields();
    olc.quantityController.text = widget.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: olc.approvalAlertFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 320,
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
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
                SizedBox(
                  height: 20,
                ),
                myTextField(
                  controller: olc.quantityController,
                  validator: olc.qtyValidator,
                  prefixIcon: Icons.numbers,
                  hintText: 'تحديد الكمية',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  validator: olc.notesValidator,
                  controller: olc.notesController,
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
            return olc.isApprovalLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: olc.isApprovalLoading.value
                        ? null
                        : () {
                            if (olc.approvalAlertFormKey.currentState!
                                .validate()) {
                              olc.approvalOrder(widget.id);
                            }
                          },
                    width: 150,
                    text: 'موافــق',
                    textStyle: MyTextStyles.font16WhiteBold,
                  );
          }),
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
