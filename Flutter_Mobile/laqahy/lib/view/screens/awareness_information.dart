import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AwarenessInformation extends StatelessWidget {
  const AwarenessInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'معلومات توعوية',
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
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
                width: 350,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: MyColors.greyColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.asset('assets/images/information-image.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: 110,
                          decoration: BoxDecoration(
                              color: MyColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'لقاح السل',
                            style: MyTextStyles.font14BlackBold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'لقللورض',
                          style: MyTextStyles.font14GreyBold,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
