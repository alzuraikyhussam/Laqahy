import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/technical_support_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import '../../../core/shared/styles/color.dart';
import '../basic_widgets/basic_widgets.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeLayoutController hlc = Get.put(HomeLayoutController());
    TechnicalSupportController tsc = Get.put(TechnicalSupportController());

    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: -180,
          top: 0,
          child: SvgPicture.asset(
            'assets/images/support.svg',
            width: 600,
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: tsc.technicalSupportFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تواصــــل معــــــنا',
                            style: MyTextStyles.font18PrimaryBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' هل لديك سؤال؟',
                                style: MyTextStyles.font16GreyBold,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ' نحن سعداء بتواصلك معنا.',
                                style: MyTextStyles.font16GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الاســـم الربـــاعي',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              myTextField(
                                controller: tsc.nameController,
                                validator: tsc.nameValidator,
                                width: 400,
                                prefixIcon: Icons.person_2_outlined,
                                hintText: 'الاسـم الربـاعي',
                                keyboardType: TextInputType.text,
                                onChanged: (String) {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'البريــد الإلـكتــروني',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              myTextField(
                                controller: tsc.emailController,
                                validator: tsc.emailValidator,
                                width: 400,
                                prefixIcon: Icons.email_outlined,
                                hintText: 'بريدك الإلكــتروني',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (String) {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نــص الـرســالـة',
                                style: MyTextStyles.font16BlackBold,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              myTextField(
                                controller: tsc.messageController,
                                validator: tsc.messageValidator,
                                width: 400,
                                maxLines: 3,
                                maxLength: 150,
                                prefixIcon: Icons.message_outlined,
                                hintText: 'اكتب رسالتك هنـــا',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (String) {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Obx(() {
                                return tsc.isLoading.value
                                    ? myLoadingIndicator(width: 130)
                                    : myButton(
                                        onPressed: () {
                                          if (tsc.technicalSupportFormKey
                                              .currentState!
                                              .validate()) {
                                            tsc.sendMsg();
                                          }
                                        },
                                        text: 'إرســــــال',
                                        textStyle: MyTextStyles.font16WhiteBold,
                                        width: 130,
                                      );
                              }),
                              SizedBox(
                                width: 15,
                              ),
                              myButton(
                                onPressed: () {
                                  hlc.changeChoose(
                                    'الرئيسية',
                                  );
                                },
                                text: 'خـــروج',
                                textStyle: MyTextStyles.font16WhiteBold,
                                width: 130,
                                backgroundColor: MyColors.greyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
