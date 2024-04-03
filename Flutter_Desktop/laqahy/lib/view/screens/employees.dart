import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/screens/create_account.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Employees extends StatelessWidget {
  const Employees({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: 250,
            height: 1000,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              border: Border(
                left: BorderSide(
                  color: MyColors.blackColor,
                  width: 0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      child: Image.asset('assets/images/app-icon.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('لــقـــــــــــاحي  |',
                        style: MyTextStyles.font16BlackBold),
                    Text('  LAQAHY', style: MyTextStyles.font16PrimaryBold),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...List.generate(
                        MyData.listMain.length,
                        (index) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 8, top: 8),
                          color: MyColors.whiteColor,
                          elevation: 0,
                          child: ListTile(
                            onTap: () {},
                            iconColor: MyColors.greyColor,
                            title: Text(
                              MyData.listMain[index]["title"],
                              style: MyTextStyles.font14GreyMedium,
                            ),
                            leading: Icon(
                              MyData.listMain[index]["icon"],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: MyColors.blackColor,
                        offset: const Offset(-7, 1),
                        blurRadius: 5,
                        spreadRadius: -3),
                  ],
                ),
                width: 890,
                height: 90,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'قائمة الموظفين',
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'مرحبا ',
                                style: MyTextStyles.font16PrimaryBold,
                              ),
                              Text(
                                ' شفيع عبده علي ',
                                style: MyTextStyles.font16GreyMedium,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.dark_mode_outlined,
                                color: MyColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30, top: 20, left: 19),
                    width: 350,
                    height: 75,
                    child: myTextField(
                        prefixIcon: Icons.search_rounded,
                        hintText: 'ادخل اسم الموظف',
                        keyboardType: TextInputType.text,
                        onChanged: (String) {}),
                  ),
                  Container(
                    width: 60,
                    height: 55,
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
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: IconButton(
                      color: MyColors.whiteColor,
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 400,
              ),
              Container(
                width: 850,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      child: myButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Expanded(
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      child: AlertDialog(
                                        title: Text('تعديل موظف'),
                                      ),
                                    ),
                                  );
                                });
                          },
                          text: 'جديد',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                    Container(
                      width: 140,
                      margin: const EdgeInsets.symmetric(horizontal: 39),
                      child: myButton(
                          onPressed: () {},
                          text: 'حذف',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                    Container(
                      width: 140,
                      child: myButton(
                          onPressed: () {},
                          text: 'خروج',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
