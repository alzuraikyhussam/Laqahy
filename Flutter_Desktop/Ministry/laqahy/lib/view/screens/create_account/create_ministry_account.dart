import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_account_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/create_account/create_admin_account.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';
import '../../widgets/basic_widgets/basic_widgets.dart';

class CreateMinistryAccountScreen extends StatefulWidget {
  const CreateMinistryAccountScreen({super.key});

  @override
  State<CreateMinistryAccountScreen> createState() =>
      _CreateMinistryAccountScreenState();
}

class _CreateMinistryAccountScreenState
    extends State<CreateMinistryAccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticDataController sdc = Get.find<StaticDataController>();

    WindowOptions createAccountWindowOptions = const WindowOptions(
      size: Size(950, 580),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(createAccountWindowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setTitle('لقــاحي | إنشاء حساب');
      await windowManager.show();
      await windowManager.focus();
    });
    sdc.fetchCities();
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
              'assets/images/image_create_account.svg',
              width: 300,
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
                    height: 40,
                  ),
                  Text(
                    'إنشاء حساب وزارة الصحة والسكان ...',
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'قم بملئ الحقول التالية لإنشاء حساب جديد للوزارة.',
                      style: MyTextStyles.font16BlackBold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: cac.createMinistryAccountFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: myTextField(
                                initialValue: 'وزارة الصحة والسكان',
                                hintText: 'اسم الوزارة',
                                prefixIcon: Icons.house_outlined,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 228,
                              child: myTextField(
                                validator: cac.centerPhoneNumberValidator,
                                controller: cac.centerPhoneNumberController,
                                prefixIcon: Icons.call_outlined,
                                hintText: 'رقم الهاتف',
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Constants().citiesDropdownMenu(),
                            const SizedBox(
                              width: 10,
                            ),
                            Constants().directoratesDropdownMenu(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 410,
                          child: myTextField(
                            validator: cac.centerAddressValidator,
                            controller: cac.centerAddressController,
                            hintText: 'العنوان',
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.location_on_outlined,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // SizedBox(
                        //   child: myTextField(
                        //     width: 410,
                        //     maxLines: 2,
                        //     maxLength: 150,
                        //     heightFactor: 1.8,
                        //     prefixIcon: Icons.message_outlined,
                        //     hintText: 'ملاحظات',
                        //     keyboardType: TextInputType.emailAddress,
                        //     onChanged: (value) {},
                        //   ),
                        // ),
                        myButton(
                          onPressed: () {
                            if (cac.createMinistryAccountFormKey.currentState!
                                .validate()) {
                              Get.to(const CreateAdminAccount());
                            }
                          },
                          width: 150,
                          text: 'التــــالي',
                          textStyle: MyTextStyles.font16WhiteBold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
