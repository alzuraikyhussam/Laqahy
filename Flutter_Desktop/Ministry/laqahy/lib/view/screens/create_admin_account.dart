import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_admin_account_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:laqahy/view/widgets/admin_verification.dart';
import 'package:window_manager/window_manager.dart';
import '../widgets/basic_widgets/basic_widgets.dart';

class CreateAdminAccount extends StatefulWidget {
  const CreateAdminAccount({super.key});

  @override
  State<CreateAdminAccount> createState() => _CreateAdminAccountState();
}

class _CreateAdminAccountState extends State<CreateAdminAccount> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions createAdminAccountWindowOptions = const WindowOptions(
      size: Size(1000, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(createAdminAccountWindowOptions,
        () async {
      await windowManager.setResizable(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setTitle('لقــاحي | إنشاء حساب المسؤول');
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    CreateAdminAccountController caac = Get.put(CreateAdminAccountController());

    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Positioned(
            left: 20,
            bottom: 0,
            top: 0,
            child: SvgPicture.asset(
              'assets/images/create-admin-account.svg',
              width: 400,
            ),
          ),
          myCopyRightText(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myAppBarLogo(),
                      goBackButton(
                        onTap: () {
                          Get.off(WelcomeScreen());
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(
                      'assets/images/create-admin-account-text.png',
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      myTextField(
                        hintText: 'الاســم الكـامل',
                        width: 300,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      myTextField(
                        hintText: 'رقــم الهـــاتف',
                        width: 235,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      myTextField(
                        hintText: 'تاريــخ الميـلاد',
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        width: 250,
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GetBuilder<CreateAdminAccountController>(
                        builder: (controller) {
                          return myDropDownMenuButton(
                            hintText: 'الجنــس',
                            items: controller.gender,
                            onChanged: (String? value) {
                              controller.changeGenderSelectedValue(value!);
                            },
                            searchController:
                                controller.genderSearchController.value,
                            selectedValue: controller.genderSelectedValue,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      myTextField(
                        hintText: 'اســم المستخــدم',
                        keyboardType: TextInputType.text,
                        width: 250,
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      myTextField(
                        hintText: 'كلمــة المــرور',
                        keyboardType: TextInputType.visiblePassword,
                        width: 250,
                        obscureText: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    hintText: 'العنـــوان',
                    keyboardType: TextInputType.text,
                    width: 440,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      myButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            barrierColor: MyColors.greyColor.withOpacity(0.5),
                            context: context,
                            builder: (context) {
                              return AdminVerification();
                            },
                          );
                        },
                        text: 'إنشــاء حســـاب المســؤول',
                        textStyle: MyTextStyles.font16WhiteBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
