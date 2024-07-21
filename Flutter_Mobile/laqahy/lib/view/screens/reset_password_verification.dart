import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/reset_password_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login/login.dart';

import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ResetPasswordVerification extends StatefulWidget {
  const ResetPasswordVerification({super.key});

  @override
  State<ResetPasswordVerification> createState() =>
      _ResetPasswordVerificationState();
}

class _ResetPasswordVerificationState extends State<ResetPasswordVerification> {
  ResetPasswordController rpc = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              padding: const EdgeInsets.all(20),
              child: Form(
                key: rpc.resetPasswordVerificationFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'نسيت كلمة المرور',
                      style: MyTextStyles.font18BlackBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'قم بإدخال رقم هاتفك  وسوف يتم إرسال كود التأكيد الى هاتفك .',
                      style: MyTextStyles.font16GreyMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    myTextField(
                      controller: rpc.phoneNumberController,
                      validator: rpc.phoneNumberValidator,
                      labelText: 'أدخل رقم الهاتف ',
                      prefixIcon: Icons.phone_enabled_outlined,
                      keyboardType: TextInputType.number,
                      onChanged: (p0) {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    myTextField(
                      controller: rpc.idNumberController,
                      validator: rpc.idNumberValidator,
                      labelText: 'أدخل الرقم الوطني ',
                      prefixIcon: Icons.perm_identity_outlined,
                      keyboardType: TextInputType.number,
                      onChanged: (p0) {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () {
                              return rpc.isLoading.value
                                  ? myLoadingIndicator()
                                  : myButton(
                                      onPressed: rpc.isLoading.value
                                          ? null
                                          : () {
                                              if (rpc
                                                  .resetPasswordVerificationFormKey
                                                  .currentState!
                                                  .validate()) {
                                                rpc.resetPasswordVerification();
                                              }
                                            },
                                      text: 'اعادة تعيين كلمة المرور',
                                      textStyle: MyTextStyles.font14WhiteBold,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
