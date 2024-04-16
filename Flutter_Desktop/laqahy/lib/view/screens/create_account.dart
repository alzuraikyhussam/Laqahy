import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_account_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/home_layout.dart';
import 'package:laqahy/view/screens/create_admin_account.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';
import '../widgets/basic_widgets/basic_widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  CreateAccountController cac = Get.put(CreateAccountController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions createAccountWindowOptions = const WindowOptions(
      size: Size(1000, 600),
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
  }

  @override
  Widget build(BuildContext context) {
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
          Padding(
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
                  height: 20,
                ),
                Text(
                  'إنشاء حساب المركز الصحي ...',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    'قم بملئ الحقول التالية لإنشاء حساب جديد لمركزك الصحي.',
                    style: MyTextStyles.font16BlackBold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: myTextField(
                        hintText: 'اسم المركز الصحي',
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 235,
                      child: myTextField(
                        hintText: 'اسم الفرع',
                        keyboardType: TextInputType.text,
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
                    GetBuilder<CreateAccountController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          hintText: 'المحافظة',
                          items: cac.cities,
                          onChanged: (String? value) {
                            controller.changeCitySelectedValue(value!);
                          },
                          searchController: cac.citySearchController.value,
                          selectedValue: cac.citySelectedValue,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GetBuilder<CreateAccountController>(
                      builder: (controller) {
                        return myDropDownMenuButton(
                          hintText: 'المديرية',
                          items: cac.directorates,
                          onChanged: (String? value) {
                            controller.changeDirectorateSelectedValue(value!);
                          },
                          searchController:
                              cac.directorateSearchController.value,
                          selectedValue: cac.directorateSelectedValue,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 228,
                      child: myTextField(
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
                SizedBox(
                  width: 440,
                  child: myTextField(
                    hintText: 'العنوان',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 440,
                    child: myTextField(
                      maxLines: 2,
                      maxLength: 150,
                      hintText: 'ملاحظات',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: myButton(
                    onPressed: () {
                      Get.off(CreateAdminAccount());
                    },
                    width: 150,
                    text: 'إنشــاء حســاب',
                    textStyle: MyTextStyles.font14WhiteBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
