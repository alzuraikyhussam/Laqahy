import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import 'basic_widgets/basic_widgets.dart';

class StateDetails extends StatelessWidget {
  const StateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'الرقم التعريفي :',
                      style: MyTextStyles.font14BlackBold,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Text(
                        '205',
                        style: MyTextStyles.font14BlackBold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      child: Text(
                        "بيانات الأم",
                        style: MyTextStyles.font14WhiteBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                ' الاسم :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'زينب محمد صالح الأشول',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' العزلة :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'جبل حبشي',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' تاريخ الميلاد :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1990-02-21',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                ' المحافظة :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تعز',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' اسم المركز الصحي :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ' مركز التعاون',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                '  رقم الهاتف :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '777777777',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                ' المديرية :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'المظفر',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.greyColor.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      child: Text(
                        "بيانات الطفل",
                        style: MyTextStyles.font14WhiteBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                ' الاسم :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'احمد عبدالله محمد صالح',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' محل الميلاد :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ' تعز-المظفر',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                ' الجنس :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '  ذكر ',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' تاريخ الميلاد :',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '2024-02-01 ',
                                style: MyTextStyles.font14GreyBold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 130,
                child: myButton(
                    onPressed: () {},
                    text: 'رجوع',
                    textStyle: MyTextStyles.font16WhiteBold),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 190,
                child: myButton(
                    onPressed: () {},
                    text: '  اضــــافــة حــالة جديدة',
                    textStyle: MyTextStyles.font16WhiteBold),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 130,
                child: myButton(
                    onPressed: () {},
                    text: 'طباعـــة',
                    textStyle: MyTextStyles.font16WhiteBold),
              ),
              const SizedBox(
                width: 20,
              ),
              // Container(
              //   width: 130,
              //   child: myButton(
              //       backgroundColor: MyColors.greyColor,
              //       onPressed: () {},
              //       text: ' خروج',
              //       textStyle: MyTextStyles.font16WhiteBold),
              // ),
            ],
          ),
          const SizedBox(
            height: 10,
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
    );
  }
}
