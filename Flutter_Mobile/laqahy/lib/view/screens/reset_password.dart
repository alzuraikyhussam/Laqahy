import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/reset_password_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key, required this.motherId});

  int motherId;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
              padding: EdgeInsets.all(20),
              child: Form(
                key: rpc.resetPasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'تغيير كلمة المرور',
                      style: MyTextStyles.font18BlackBold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' قم بأدخال كلمة مرور جديدة لحسابك',
                      style: MyTextStyles.font16GreyMedium,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Obx(() {
                      return myTextField(
                          controller: rpc.passwordController,
                          validator: rpc.passwordValidator,
                          labelText: 'ادخل كلمة المرور الجديدة',
                          prefixIcon: Icons.password_outlined,
                          suffixIcon: rpc.isVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: rpc.isVisible.value ? false : true,
                          onChanged: (p0) {},
                          onTapSuffixIcon: () {
                            rpc.changePasswordVisibility();
                          });
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return myTextField(
                          controller: rpc.passwordController2,
                          validator: rpc.passwordValidator2,
                          labelText: 'أعد ادخال كلمة المرور',
                          prefixIcon: Icons.password_outlined,
                          suffixIcon: rpc.isVisible2.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: rpc.isVisible2.value ? false : true,
                          onChanged: (p0) {},
                          onTapSuffixIcon: () {
                            rpc.changePasswordVisibility2();
                          });
                    }),
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
                                              if (rpc.resetPasswordFormKey
                                                  .currentState!
                                                  .validate()) {
                                                rpc.resetPassword(motherId: widget.motherId);
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
