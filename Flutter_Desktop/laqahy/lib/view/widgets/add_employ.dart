import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddEmploy extends StatefulWidget {
  const AddEmploy({super.key});

  @override
  State<AddEmploy> createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {
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
              children: [
                Container(
                  width: 1000,
                  child: Text(
                    'اضافة موظف جديد ',
                    textAlign: TextAlign.center,
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  اسم الموظف',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 300,
                          child: myTextField(
                              prefixIcon: Icons.person_outline_sharp,
                              hintText: '',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {}),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      رقم الهاتف',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 3),
                          width: 200,
                          child: myTextField(
                            prefixIcon: Icons.phone_outlined,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (String) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  الجنس ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 150,
                          child: myTextField(
                              prefixIcon: Icons.male_outlined,
                              hintText: '',
                              keyboardType: TextInputType.text,
                              onChanged: (String) {}),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  اسم المستخدم ',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 3),
                            width: 230,
                            child: myTextField(
                                prefixIcon: Icons.person,
                                hintText: '',
                                keyboardType: TextInputType.text,
                                onChanged: (String) {}),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  كلمة المرور ',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            width: 230,
                            child: myTextField(
                                prefixIcon: Icons.lock,
                                hintText: '',
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (String) {}),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   تاريخ الميلاد ',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 3),
                            width: 230,
                            child: myTextField(
                                prefixIcon: Icons.date_range_outlined,
                                hintText: '',
                                keyboardType: TextInputType.datetime,
                                onChanged: (String) {}),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   تحديد الصلاحيه ',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            width: 200,
                            child: myTextField(
                                prefixIcon: Icons.shield,
                                hintText: '',
                                keyboardType: TextInputType.text,
                                onChanged: (String) {}),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 130,
                        child: myButton(
                            onPressed: () {},
                            text: 'اضافة',
                            textStyle: MyTextStyles.font16WhiteBold),
                      ),
                      Container(
                        width: 140,
                        child: myButton(
                            onPressed: () {},
                            text: 'الغـــاء اللأمــر',
                            textStyle: MyTextStyles.font16WhiteBold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
