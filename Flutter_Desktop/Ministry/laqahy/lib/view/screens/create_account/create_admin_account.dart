import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/create_account_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/create_account/create_ministry_account.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';
import '../../widgets/basic_widgets/basic_widgets.dart';

class CreateAdminAccount extends StatefulWidget {
  const CreateAdminAccount({super.key});

  @override
  State<CreateAdminAccount> createState() => _CreateAdminAccountState();
}

class _CreateAdminAccountState extends State<CreateAdminAccount> {
  @override
  void initState() {
    StaticDataController sdc = Get.find<StaticDataController>();

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
    sdc.fetchGenders();
  }

  @override
  Widget build(BuildContext context) {
    CreateAccountController cac = Get.put(CreateAccountController());

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myAppBarLogo(),
                      goBackButton(
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                  Form(
                    key: cac.createAdminAccountFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            myTextField(
                              validator: cac.nameValidator,
                              hintText: 'الاســم الرباعي',
                              controller: cac.nameController,
                              width: 300,
                              prefixIcon: Icons.person_2_outlined,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            myTextField(
                              controller: cac.phoneNumberController,
                              validator: cac.phoneNumberValidator,
                              hintText: 'رقــم الهـــاتف',
                              prefixIcon: Icons.call_outlined,
                              width: 235,
                              keyboardType: TextInputType.phone,
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
                              validator: cac.birthdateValidator,
                              controller: cac.birthdateController,
                              hintText: 'تاريــخ الميـلاد',
                              prefixIcon: Icons.date_range_outlined,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              width: 250,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now())
                                    .then(
                                  (value) {
                                    if (value == null) {
                                      return;
                                    } else {
                                      cac.birthdateController.text =
                                          DateFormat.yMMMd().format(value);
                                    }
                                  },
                                );
                              },
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Constants().gendersDropdownMenu(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            myTextField(
                              validator: cac.userNameValidator,
                              controller: cac.userNameController,
                              hintText: 'اســم المستخدم',
                              prefixIcon: Icons.person_pin_outlined,
                              keyboardType: TextInputType.text,
                              width: 250,
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(() {
                              return myTextField(
                                hintText: 'كلمــة المــرور',
                                controller: cac.passwordController,
                                validator: cac.passwordValidator,
                                prefixIcon: Icons.lock_outline_rounded,
                                keyboardType: TextInputType.visiblePassword,
                                width: 250,
                                suffixIcon: cac.isVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                obscureText: cac.isVisible.value ? false : true,
                                onChanged: (value) {},
                                onTapSuffixIcon: () {
                                  cac.changePasswordVisibility();
                                },
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        myTextField(
                          hintText: 'العنـــوان',
                          controller: cac.addressController,
                          validator: cac.addressValidator,
                          prefixIcon: Icons.location_on_outlined,
                          keyboardType: TextInputType.text,
                          width: 440,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Obx(() {
                              return cac.isLoading.value
                                  ? myLoadingIndicator()
                                  : myButton(
                                      onPressed: cac.isLoading.value
                                          ? null
                                          : () {
                                              if (cac.createAdminAccountFormKey
                                                  .currentState!
                                                  .validate()) {
                                                cac.createAccount();
                                              }
                                            },
                                      text: 'إنشـــاء حســـاب',
                                      textStyle: MyTextStyles.font16WhiteBold,
                                    );
                            }),
                          ],
                        ),
                      ],
                    ),
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
