import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import '../widgets/basic_widgets/basic_widgets.dart';
import '../widgets/icons/my_flutter_app_icons.dart';

class CreateAdminAccount extends StatelessWidget {
  const CreateAdminAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/app-icon.png',
                      width: 50, height: 50),
                  const SizedBox(width: 20),
                  const Text(
                    'لــقـــاحي  |',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '  LAQAHY',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'إنشــاء حســاب المسؤول',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'A D M I N   R E G I S T E R',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ],
                ),
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
                              hintText: 'الاسم الكامل',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: myTextField(
                              prefixIcon: MyFlutterApp.phone_handset,
                              hintText: 'رقم الهاتف',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: myTextField(
                              hintText: 'تاريخ الميلاد',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              border: Border.all(
                                color: MyColors.greyColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 170,
                            height: 54,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'الجنس',
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
                          SizedBox(
                            width: 250,
                            child: myTextField(
                              hintText: 'اسم المسـتـخدم',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: myTextField(
                              hintText: 'كلمة الـمـرور',
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
                          prefixIcon: MyFlutterApp.location,
                          hintText: 'العنوان',
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
                  const SizedBox(
                    width: 100,
                  ),
                  Image.asset("assets/images/create_admin_account.png"),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:MyColors.greyColor,
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
