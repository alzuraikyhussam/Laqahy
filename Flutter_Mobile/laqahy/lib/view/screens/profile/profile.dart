import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width,
              height: 280,
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: 250,
                    child: Image.asset(
                      'assets/images/curve.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 45,
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.secondaryColor,
                            ),
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              sdc.greeting.value,
                              style: MyTextStyles.font14BlackBold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            sdc.userLoggedData.first.user.motherName ??
                                'مجهول الهوية',
                            style: MyTextStyles.font16WhiteBold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'الرقم الوطني: ${sdc.userLoggedData.first.user.identityNum}',
                            style: MyTextStyles.font14WhiteMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    bottom: 0,
                    child: Container(
                      width: 130,
                      height: 130,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 5,
                          color: MyColors.secondaryColor,
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/profile-image.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsetsDirectional.all(15),
                children: [
                  Card(
                    child: Column(
                      children: [
                        myProfileListTile(
                          icon: Icons.home_work_outlined,
                          label: 'اسم المركز :',
                          value:
                              sdc.userLoggedData.first.user.healthCenterName ??
                                  '',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        const Divider(),
                        myProfileListTile(
                          icon: Icons.phone_android_rounded,
                          label: 'رقم الجوال :',
                          value: sdc.userLoggedData.first.user.phoneNum ?? '',
                        ),
                        const Divider(),
                        myProfileListTile(
                          icon: Icons.date_range_outlined,
                          label: 'تاريخ الميلاد :',
                          value: DateFormat('yyyy-MM-dd')
                              .format(sdc.userLoggedData.first.user.birthDate!)
                              .toString(),
                        ),
                        const Divider(),
                        myProfileListTile(
                          icon: Icons.place_outlined,
                          label: 'المحافظة :',
                          value: sdc.userLoggedData.first.user.city ?? '',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        const Divider(),
                        myProfileListTile(
                          icon: Icons.location_history_outlined,
                          label: 'المديرية :',
                          value:
                              sdc.userLoggedData.first.user.directorate ?? '',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        const Divider(),
                        myProfileListTile(
                          icon: Icons.holiday_village_outlined,
                          label: 'العزلة :',
                          value: sdc.userLoggedData.first.user.village ?? '',
                          style: MyTextStyles.font14BlackBold,
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
      ),
    );
  }
}
