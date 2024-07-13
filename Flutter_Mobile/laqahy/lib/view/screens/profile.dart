import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    StaticDataController sdc = Get.put(StaticDataController());
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsetsDirectional.only(
                start: 20,
                end: 20,
              ),
              margin: EdgeInsetsDirectional.symmetric(
                horizontal: 30,
              ),
              height: 390,
              decoration: BoxDecoration(
                color: MyColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  // Text(
                  //   '${sdc.userLoggedData.first.motherName}',
                  //   style: MyTextStyles.font16BlackBold,
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'تاريخ الميلاد',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.birthDate}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'رقم الهاتف',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.phoneNum}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'اسم المركز',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.healthCenterName}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                'الفرع',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.healthCenterId}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'المحافظة',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.city}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'المديرية',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.directorate}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'العزلة',
                                style: MyTextStyles.font14BlackBold,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.secondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Text(
                                //   '${sdc.userLoggedData.first.village}',
                                //   style: MyTextStyles.font16BlackBold,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 90,
            child: Container(
              margin: EdgeInsetsDirectional.symmetric(
                horizontal: 140,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: MyColors.primaryColor,
                  ),
                  borderRadius: BorderRadiusDirectional.circular(500)),
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person_3_outlined,
                  color: MyColors.primaryColor,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
