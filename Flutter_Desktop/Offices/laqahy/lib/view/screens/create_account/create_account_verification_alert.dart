import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_account_verification_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateAccountVerificationAlert extends StatefulWidget {
  const CreateAccountVerificationAlert({super.key});

  @override
  State<CreateAccountVerificationAlert> createState() =>
      _CreateAccountVerificationAlertState();
}

class _CreateAccountVerificationAlertState
    extends State<CreateAccountVerificationAlert> {
  CreateAccountVerificationController cav =
      Get.put(CreateAccountVerificationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cav.createAccountVerification,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 220,
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myAppBarLogo(
                        width: 250,
                      ),
                    ],
                  ),
                ),
                Text(
                  'أدخــل كــود التحــقق',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return myTextField(
                    width: 300,
                    controller: cav.codeController,
                    validator: cav.codeValidator,
                    prefixIcon: Icons.password,
                    obscureText: cav.isVisible.value ? false : true,
                    suffixIcon: cav.isVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    hintText: 'كود التحقق',
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {},
                    onTapSuffixIcon: () {
                      cav.changeVisibility();
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return cav.isVerifyLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: cav.isVerifyLoading.value
                        ? null
                        : () {
                            if (cav.createAccountVerification.currentState!
                                .validate()) {
                              cav.checkCodeVerification();
                            }
                          },
                    width: 150,
                    text: 'تحــقق',
                    textStyle: MyTextStyles.font16WhiteBold,
                  );
          }),
          myButton(
            width: 150,
            onPressed: () {
              Get.back();
            },
            text: 'إلـغــاء الأمـــر',
            textStyle: MyTextStyles.font16WhiteBold,
            backgroundColor: MyColors.greyColor,
          ),
        ],
      ),
    );
  }
}
