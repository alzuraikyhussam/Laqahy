import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class awarenessinformation extends StatefulWidget {
  const awarenessinformation({super.key});

  @override
  State<awarenessinformation> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<awarenessinformation> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: myAppBar(
        text: '',
        showBackButton: true,
        onTap: () {
          Get.back();
        },
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Text(
                    '  معلومات توعيه',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]
              ),
            ),
          ]
        ),
      ),
    );

  
  }
  }