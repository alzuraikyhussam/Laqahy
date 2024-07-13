import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'تواصل بنا',
        onTap: () {
          Get.back();
        },
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 250,
                    child: Image.asset(
                      'assets/images/contact-us-image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                    labelText: 'أدخل اسمك هنا',
                    keyboardType: TextInputType.text,
                    onChanged: (s) {},
                    width: 350,
                    prefixIcon: Icons.person_2_outlined,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  myTextField(
                    labelText: 'بريدك الالكتروني',
                    keyboardType: TextInputType.text,
                    onChanged: (s) {},
                    width: 350,
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  myTextField(
                    labelText: 'وصف المشكلة',
                    keyboardType: TextInputType.text,
                    onChanged: (s) {},
                    width: 350,
                    prefixIcon: Icons.note_add_outlined,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  myButton(
                    onPressed: () {},
                    text: 'ارســــال',
                    textStyle: MyTextStyles.font16WhiteBold,
                    width: 350,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
