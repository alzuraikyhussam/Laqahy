import 'package:flutter/material.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class MotherVisitData extends StatefulWidget {
  const MotherVisitData({super.key});

  @override
  State<MotherVisitData> createState() => _MotherVisitDataState();
}

class _MotherVisitDataState extends State<MotherVisitData> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          image: const DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: 350,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryColor,
                              MyColors.secondaryColor,
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                        ),
                        width: 165,
                        height: 42,
                        child: Center(
                          child: Text(
                            'بيانات الأم',
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 165,
                        height: 42,
                        child: Center(
                          child: Text(
                            'بيانات الطفــل',
                            style: MyTextStyles.font14PrimaryBold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  الأسم  ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 3),
                          width: 300,
                          child: myTextField(
                            prefixIcon: Icons.woman,
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
                          ' مرحلة الجرعة  ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 3),
                          width: 250,
                          child: myTextField(
                            prefixIcon: Icons.vaccines_outlined,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (String) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      width: 122,
                      child: CheckboxListTile(
                        fillColor:
                            MaterialStateProperty.all(Colors.transparent),
                        controlAffinity: ListTileControlAffinity.leading,
                        side: BorderSide(
                          color: MyColors.primaryColor,
                        ),
                        checkColor: MyColors.primaryColor,
                        value: state,
                        onChanged: (val) {
                          setState(() {
                            state = val!;
                          });
                        },
                        title: Text(
                          'الاولى',
                          style: MyTextStyles.font14BlackBold,
                        ),
                      ),
                    ),
                    Container(
                      width: 122,
                      child: CheckboxListTile(
                        fillColor:
                            MaterialStateProperty.all(Colors.transparent),
                        controlAffinity: ListTileControlAffinity.leading,
                        side: BorderSide(
                          color: MyColors.primaryColor,
                        ),
                        checkColor: MyColors.primaryColor,
                        activeColor: Colors.white,
                        title: Text(
                          'الثانية',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        value: state,
                        onChanged: (val) {
                          setState(() {
                            state = val!;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 122,
                      child: CheckboxListTile(
                        fillColor:
                            MaterialStateProperty.all(Colors.transparent),
                        controlAffinity: ListTileControlAffinity.leading,
                        side: BorderSide(
                          color: MyColors.primaryColor,
                        ),
                        checkColor: MyColors.primaryColor,
                        title: Text(
                          'الثالثة',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        value: true,
                        onChanged: (value) => '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      width: 130,
                      child: myButton(
                          onPressed: () {},
                          text: 'اضافة',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 130,
                      child: myButton(
                          backgroundColor: MyColors.greyColor,
                          onPressed: () {},
                          text: 'خروج',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
