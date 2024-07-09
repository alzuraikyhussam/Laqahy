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
    super.initState();
    StaticDataController sdc = Get.find<StaticDataController>();
    sdc.fetchCities();
  }

  CreateAccountController cac = Get.put(CreateAccountController());

  @override
  Widget build(BuildContext context) {
    WindowOptions createAccountWindowOptions = const WindowOptions(
      size: Size(900, 560),
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

    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Positioned(
            left: 30,
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
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myAppBarLogo(),
                      goBackButton(
                        onTap: () {
                          Get.off(const WelcomeScreen());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'إنشاء حساب وزارة الصحة والسكان ...',
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Text(
                      'قم بملئ الحقول التالية لإنشاء حساب وزارة الصحة والسكان في الجمهورية اليمنية.',
                      style: MyTextStyles.font16BlackBold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: cac.createMinistryAccountFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myTextField(
                          width: 300,
                          initialValue: 'وزارة الصحة والسكان',
                          hintText: 'اسم الوزارة',
                          prefixIcon: Icons.house_outlined,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            myTextField(
                              width: 228,
                              validator: cac.centerPhoneNumberValidator,
                              controller: cac.centerPhoneNumberController,
                              prefixIcon: Icons.call_outlined,
                              hintText: 'رقم الهاتف',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Constants().citiesDropdownMenu(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        myTextField(
                          width: 410,
                          validator: cac.centerAddressValidator,
                          controller: cac.centerAddressController,
                          hintText: 'العنوان',
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.location_on_outlined,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
