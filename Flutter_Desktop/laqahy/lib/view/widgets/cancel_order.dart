import 'package:flutter/cupertino.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CancelOrders extends StatefulWidget {
  const CancelOrders({super.key});

  @override
  State<CancelOrders> createState() => _CancelOrdersState();
}

class _CancelOrdersState extends State<CancelOrders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return myOrdersItem(
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
                        'سـبب الـرفــض:',
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16RedBold,
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
