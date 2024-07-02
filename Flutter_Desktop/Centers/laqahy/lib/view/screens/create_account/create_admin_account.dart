import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/create_admin_account_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
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
              child: Form(
                key: caac.createAdminAccountFormKey,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/images/create-admin-account-text.png',
                        width: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        myTextField(
                          controller: caac.nameController,
                          validator: caac.nameValidator,
                          hintText: 'الاســم الكـامل',
                          width: 300,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        myTextField(
                          controller: caac.phoneNumberController,
                          validator: caac.phoneNumberValidator,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              child: myTextField(
                                validator: caac.birthDateValidator,
                                controller: caac.birthDateController,
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
                                        caac.birthDateController.text =
                                            DateFormat.yMMMd().format(value);
                                      }
                                    },
                                  );
                                },
                                onChanged: (value) {},
                              ),
                            )
                          ],
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
                          controller: caac.userNameController,
                          validator: caac.userNameValidator,
                          hintText: 'اســم المستخــدم',
                          keyboardType: TextInputType.text,
                          width: 250,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        myTextField(
                          controller: caac.passwordController,
                          validator: caac.passwordValidator,
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
                      controller: caac.addressController,
                      validator: caac.addressValidator,
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
                            Obx(() {
                              return caac.isLoading.value
                                  ? myLoadingIndicator()
                                  : myButton(
                                      onPressed: caac.isLoading.value
                                          ? null
                                          : () {
                                              if (caac.createAdminAccountFormKey
                                                  .currentState!
                                                  .validate()) {
                                                caac.createAccount();
                                              }
                                            },
                                      text: 'إنشـــاء الحســـاب',
                                      textStyle: MyTextStyles.font16WhiteBold,
                                    );
                            }),
                          ],
                        ),
                      
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
