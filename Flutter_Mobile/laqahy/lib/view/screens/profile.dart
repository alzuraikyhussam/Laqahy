import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'الملف الشخصي'),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: MyColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'زينب صالح مجمد',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('تاريخ الميلاد'),
                          myTextField(
                              labelText: '',
                              keyboardType: TextInputType.text,
                              onChanged: (S) {},
                              width: 150,
                              fillColor: Colors.transparent),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 100,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: MyColors.brownColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
