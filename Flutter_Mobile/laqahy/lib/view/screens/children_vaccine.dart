import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ChildrenVaccine extends StatelessWidget {
  const ChildrenVaccine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'لقــاحـــات الطفــــل', onTap: () => Get.back()),
      body: Column(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyColors.secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 360,
                      height: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'لقاحات طفلك',
                                style: MyTextStyles.font14PrimaryMedium,
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                ' محمد صالح الاشول',
                                style: MyTextStyles.font16BlackBold,
                              ),
                            ],
                          ),
                          Container(
                            child:
                                Image.asset('assets/images/mother-vaccine.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 30,
                  top: 80,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: 70,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.child_care_outlined,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        Text(
                          'العمر',
                          style: MyTextStyles.font14PrimaryBold,
                        ),
                        Divider(
                          thickness: 3,
                          indent: 25,
                          endIndent: 25,
                          color: MyColors.primaryColor,
                          height: 3,
                        ),
                        Text(' 30 يوم')
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 105,
                  top: 80,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.date_range_outlined,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        Text(
                          'موعد العودة',
                          style: MyTextStyles.font14PrimaryBold,
                        ),
                        Divider(
                          thickness: 3,
                          indent: 40,
                          endIndent: 40,
                          color: MyColors.primaryColor,
                          height: 3,
                        ),
                        Text('20-05-2024')
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 210,
                  top: 80,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    width: 70,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.date_range_outlined,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        Text(
                          'الجنس',
                          style: MyTextStyles.font14PrimaryBold,
                        ),
                        Divider(
                          thickness: 3,
                          indent: 25,
                          endIndent: 25,
                          color: MyColors.primaryColor,
                          height: 3,
                        ),
                        Text('ذكر')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
