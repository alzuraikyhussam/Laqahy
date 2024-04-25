import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class WaitingOrders extends StatefulWidget {
  const WaitingOrders({super.key});

  @override
  State<WaitingOrders> createState() => _WaitingOrdersState();
}

class _WaitingOrdersState extends State<WaitingOrders> {
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
                        'ملاحظة الوزارة:',
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll------------------------------------------------------------------------------------------------------------------------------------------------------llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: MyColors.greyColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll------------------------------------------------------------------------------------------------------------------------------------------------------llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: MyTextStyles.font16GreyBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    myButton(
                      width: 120,
                      onPressed: () {
                        // myShowDialog(context: context, widgetName: OrderConfirmationSuccessfully());
                      },
                      text: 'تــأكيـــــد',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
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
