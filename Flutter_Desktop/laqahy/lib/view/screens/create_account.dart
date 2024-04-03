import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import '../widgets/basic_widgets/basic_widgets.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إنشاء حساب المركز الصحي ...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const Text(
                    'قم بملئ الحقول التالية لإنشاء حساب جديد',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'لمركزك الصحي',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              onChanged: (String) {},
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
                              onChanged: (String) {},
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
