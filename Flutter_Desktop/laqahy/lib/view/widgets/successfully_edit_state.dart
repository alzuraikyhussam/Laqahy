import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class SuccessfullyEditState extends StatelessWidget {
  const SuccessfullyEditState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/successfully_image.png"),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              'تم التعـــديل بنجاح',
              style: MyTextStyles.font16PrimaryBold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              '  لقد تم تعديــل الحالة بنجاح ',
              style: MyTextStyles.font14GreyBold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 130,
            child: myButton(
                onPressed: () {},
                text: 'موافق',
                textStyle: MyTextStyles.font16WhiteBold),
          ),
        ],
      ),
    ));
  }
}
