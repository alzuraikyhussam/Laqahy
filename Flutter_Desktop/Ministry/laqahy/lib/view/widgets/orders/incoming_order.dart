import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/orders/approval_order_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/orders/reject_confirm_alert.dart';

class IncomingOrder extends StatefulWidget {
  const IncomingOrder({super.key});

  @override
  State<IncomingOrder> createState() => _IncomingOrderState();
}

class _IncomingOrderState extends State<IncomingOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return myOrdersItem(
            height: 200,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            'اسم المركز الصحي:',
                            style: MyTextStyles.font16PrimaryBold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'مركز المظفر',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: MyTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            'اسم اللقــاح:',
                            style: MyTextStyles.font16PrimaryBold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'شلل الاطفال',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: MyTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'الكميــة:',
                            style: MyTextStyles.font16PrimaryBold,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '200',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: MyTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ملاحظــة:',
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'lllllllllllllllllllll------------------------------------------lllllllllllllllll',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: MyTextStyles.font16BlackBold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    myButton(
                      onPressed: () {
                        myShowDialog(
                            context: context, widgetName: ApprovalOrderAlert());
                      },
                      text: 'موافقة',
                      textStyle: MyTextStyles.font14WhiteBold,
                      width: 150,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    myButton(
                        onPressed: () {
                          myShowDialog(
                              context: context,
                              widgetName: RejectConfirmAlert());
                        },
                        text: 'رفض',
                        textStyle: MyTextStyles.font14WhiteBold,
                        width: 150,
                        backgroundColor: MyColors.redColor),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
