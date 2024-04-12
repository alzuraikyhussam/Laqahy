import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/home_layout.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';
import '../widgets/basic_widgets/basic_widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final List<String> items = [
    'مملكه الفول',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? cityselectedValue;
  String? areaselectedValue;

  bool state = false;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    goBackButton(),
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.home_work_outlined,
                              size: 16,
                              color: MyColors.greyColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'المحافظة',
                              style: MyTextStyles.font14GreyMedium,
                            ),
                          ],
                        ),
                        items: items
                            .map(
                              (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: MyTextStyles.font14BlackBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                            .toList(),
                        value: cityselectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            cityselectedValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 54,
                          width: 200,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: MyColors.greyColor.withOpacity(0.3)),
                            color: MyColors.whiteColor,
                          ),
                          elevation: 0,
                        ),
                        iconStyleData: IconStyleData(
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: MyColors.greyColor,
                          iconDisabledColor: MyColors.greyColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.whiteColor,
                          ),
                          // offset: const Offset(-29, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                            MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 50,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.home_work_outlined,
                              size: 16,
                              color: MyColors.greyColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'المديرية',
                              style: MyTextStyles.font14GreyMedium,
                            ),
                          ],
                        ),
                        items: items
                            .map(
                              (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: MyTextStyles.font14BlackBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                            .toList(),
                        value: cityselectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            cityselectedValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 54,
                          width: 200,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: MyColors.greyColor.withOpacity(0.3)),
                            color: MyColors.whiteColor,
                          ),
                          elevation: 0,
                        ),
                        iconStyleData: IconStyleData(
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: MyColors.greyColor,
                          iconDisabledColor: MyColors.greyColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.whiteColor,
                          ),
                          // offset: const Offset(-29, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                            MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 50,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 228,
                      child: myTextField(
                        hintText: 'رقم الهاتف',
                        keyboardType: TextInputType.text,
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
                      minLines: 2,
                      maxLength: 150,
                      hintText: 'ملاحظات',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      myButton(
                        onPressed: () {
                          Get.offAll(HomeLayout());
                        },
                        text: 'إنشــاء حســاب',
                        textStyle: MyTextStyles.font14WhiteMedium,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      myButton(
                        onPressed: () {
                          Get.off(WelcomeScreen());
                        },
                        text: 'إلغـاء الأمـر',
                        textStyle: MyTextStyles.font14WhiteMedium,
                        backgroundColor: MyColors.greyColor,
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
        ],
      ),
    );

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          color: MyColors.blackColor,
        ),
        Container(
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            border: Border.all(
              width: 3,
              color: MyColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/window-logo.png',
                width: 220,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إنشاء حساب المركز الصحي ...',
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: Text(
                      'قم بملئ الحقول التالية لإنشاء حساب جديد لمركزك الصحي.',
                      style: MyTextStyles.font16BlackBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            width: 228,
                            child: myTextField(
                              hintText: 'اسم الفرع',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              border: Border.all(
                                color: MyColors.greyColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 202,
                            height: 54,
                            child: Row(
                              children: [
                                Text(
                                  'المحافظة',
                                  style: MyTextStyles.font14GreyMedium,
                                ),
                                const Spacer(),
                                DropdownButton(
                                    items: const [],
                                    onChanged: ((value) => {})),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              border: Border.all(
                                color: MyColors.greyColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 202,
                            height: 54,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: MyColors.greyColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'المديرية',
                                  style: MyTextStyles.font14GreyMedium,
                                ),
                                const Spacer(),
                                DropdownButton(
                                    items: const [],
                                    onChanged: ((value) => {})),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 228,
                            child: myTextField(
                              hintText: 'رقم الهاتف',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {},
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
                          onChanged: (String) {},
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 440,
                        child: myTextField(
                          hintText: 'ملاحظات',
                          keyboardType: TextInputType.text,
                          onChanged: (String) {},
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          myButton(
                            onPressed: () {},
                            text: 'إنشــاء الحســاب',
                            textStyle: MyTextStyles.font14WhiteMedium,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          myButton(
                            onPressed: () {},
                            text: 'إلغاء الأمر',
                            textStyle: MyTextStyles.font14WhiteMedium,
                            backgroundColor: MyColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset("assets/images/image_create_account.png")
                ],
              ),
              Expanded(
                child: Container(
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'جميع الحقوق محفوظة ${DateTime.now().year} ©',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.greyColor,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
