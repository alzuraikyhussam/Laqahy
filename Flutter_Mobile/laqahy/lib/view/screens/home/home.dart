import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/about_app/about_app.dart';
import 'package:laqahy/view/screens/awareness_info/awareness_information.dart';
import 'package:laqahy/view/screens/child_vaccines/choose_children.dart';
import 'package:laqahy/view/screens/contact/contact_us.dart';
import 'package:laqahy/view/screens/mother_vaccines/mother_vaccine.dart';
import 'package:laqahy/view/screens/settings/settings.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController hc = Get.put(HomeController());

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 15,
              end: 15,
              bottom: 20,
              top: 10,
            ),
            child: Column(
              children: [
                SizedBox(
                  // height: 150,
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/home_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: hc.homeGridViewItems[index].onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              hc.homeGridViewItems[index].icon,
                              size: 60,
                              color: MyColors.primaryColor,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              hc.homeGridViewItems[index].title,
                              style: MyTextStyles.font14BlackBold,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const ContactUsScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: 65,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: MyColors.greyColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        MyColors.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: 45,
                                  height: Get.height,
                                  child: Icon(
                                    Icons.message_outlined,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'تواصل بنا',
                                        style: MyTextStyles.font16PrimaryBold,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'خدمة دائمة على مدار 24 ساعة',
                                          style: MyTextStyles.font14GreyBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 30,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            textDirection: TextDirection.ltr,
                            color: MyColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const AboutAppScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: 65,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: MyColors.greyColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        MyColors.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: 45,
                                  height: Get.height,
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'حول التطبيق',
                                        style: MyTextStyles.font16PrimaryBold,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'معلومات حول التطبيق وخدماته',
                                          style: MyTextStyles.font14GreyBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 30,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            textDirection: TextDirection.ltr,
                            color: MyColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
