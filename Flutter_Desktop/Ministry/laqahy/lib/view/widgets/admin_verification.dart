import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/admin_verification_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/layouts/home_layout.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class AdminVerification extends StatefulWidget {
  const AdminVerification({super.key});

  @override
  State<AdminVerification> createState() => _AdminVerificationState();
}

class _AdminVerificationState extends State<AdminVerification> {
  AdminVerificationController avc = Get.put(AdminVerificationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: avc.adminVerificationFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 320,
          width: 400,
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Text(
                'أدخــل رمــز التـحقــق',
                style: MyTextStyles.font18PrimaryBold,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  'الرجاء إدخال رمز التحقق الذي تم إرساله الى رقم جوالك.',
                  style: MyTextStyles.font16BlackMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return myTextField(
                  validator: avc.codeValidator,
                  controller: avc.codeController,
                  width: 300,
                  suffixIcon: avc.isVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  obscureText: avc.isVisible.value ? false : true,
                  onChanged: (value) {},
                  onTapSuffixIcon: () {
                    avc.changePasswordVisibility();
                  },
                  hintText: 'أدخـــل رمــز التـحــقــق',
                  keyboardType: TextInputType.visiblePassword,
                  textAlign: TextAlign.center,
                );
              }),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      'لم يصل الكود؟',
                      style: MyTextStyles.font16GreyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  myTextButton(
                    text: 'إعــادة إرســال',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          myButton(
            onPressed: () {
              if (avc.adminVerificationFormKey.currentState!.validate()) {
                Get.offAll(HomeLayout());
              }
            },
            width: 150,
            text: 'تـأكيـــــد',
            textStyle: MyTextStyles.font16WhiteBold,
          ),
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
