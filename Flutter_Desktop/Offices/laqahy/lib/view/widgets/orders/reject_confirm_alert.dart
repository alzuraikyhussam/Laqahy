import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class RejectConfirmAlert extends StatefulWidget {
  RejectConfirmAlert({super.key, required this.id});

  int id;

  @override
  State<RejectConfirmAlert> createState() => _RejectConfirmAlertState();
}

class _RejectConfirmAlertState extends State<RejectConfirmAlert> {
  OrdersController oc = Get.put(OrdersController());

  @override
  void initState() {
    oc.clearTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: oc.rejectAlertFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 250,
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
                  'هل أنت متأكد من عملية رفض الطلب؟',
                  style: MyTextStyles.font16RedBold,
                ),
                SizedBox(
                  height: 20,
                ),
                myTextField(
                  validator: oc.rejectReasonValidator,
                  controller: oc.rejectReasonController,
                  maxLines: 2,
                  maxLength: 150,
                  heightFactor: 1.8,
                  prefixIcon: Icons.info_outline_rounded,
                  hintText: 'سبب الرفض',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return oc.isRejectLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: oc.isRejectLoading.value
                        ? null
                        : () {
                            if (oc.rejectAlertFormKey.currentState!
                                .validate()) {
                              oc.rejectCenterOrder(widget.id);
                            }
                          },
                    width: 150,
                    backgroundColor: MyColors.redColor,
                    text: 'رفـــض',
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
