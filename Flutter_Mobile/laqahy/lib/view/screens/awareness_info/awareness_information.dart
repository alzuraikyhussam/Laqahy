import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AwarenessInfoScreen extends StatelessWidget {
  const AwarenessInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'معلومات توعوية',
        onTap: () {
          Get.back();
        },
      ),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/awareness-information-image.png',
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اكتشفي أهمية اللقاحات',
                                style: MyTextStyles.font14PrimaryBold,
                              ),
                              Text(
                                'للحفاظ على صحة عائلتك.',
                                style: MyTextStyles.font16BlackBold,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: Get.width,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColors.greyColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: 120,
                        height: Get.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/information-image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  color: MyColors.primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'لقاح السل',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: MyTextStyles.font14BlackBold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Text(
                                'لقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورضلقللورض',
                                style: MyTextStyles.font14GreyBold,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text('data'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
