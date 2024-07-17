import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/technical_support_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TechnicalSupportController tsc = Get.put(TechnicalSupportController());

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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: tsc.technicalSupportFormKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 250,
                    child: Image.asset(
                      'assets/images/contact-us-image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    controller: tsc.nameController,
                    validator: tsc.nameValidator,
                    width: Get.width,
                    prefixIcon: Icons.person_2_outlined,
                    labelText: 'الاسـم الربـاعي',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    controller: tsc.emailController,
                    validator: tsc.emailValidator,
                    width: Get.width,
                    prefixIcon: Icons.email_outlined,
                    labelText: 'بريدك الإلكــتروني',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    controller: tsc.messageController,
                    validator: tsc.messageValidator,
                    width: Get.width,
                    maxLines: 3,
                    maxLength: 150,
                    prefixIcon: Icons.message_outlined,
                    labelText: 'اكتب رسالتك هنـــا',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return tsc.isLoading.value
                        ? myLoadingIndicator()
                        : myButton(
                            onPressed: () {
                              if (tsc.technicalSupportFormKey.currentState!
                                  .validate()) {
                                tsc.sendMsg();
                              }
                            },
                            text: 'إرســــــال',
                            textStyle: MyTextStyles.font16WhiteBold,
                            width: Get.width,
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
