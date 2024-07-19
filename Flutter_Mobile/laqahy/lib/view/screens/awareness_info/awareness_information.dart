import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/awareness_info_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AwarenessInfoScreen extends StatefulWidget {
  const AwarenessInfoScreen({super.key});

  @override
  State<AwarenessInfoScreen> createState() => _AwarenessInfoScreenState();
}

class _AwarenessInfoScreenState extends State<AwarenessInfoScreen> {
  AwarenessInfoController aic = Get.put(AwarenessInfoController());

  @override
  void initState() {
    aic.fetchAwarenessInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'معلومات توعوية',
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
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 15,
            end: 15,
            bottom: 15,
            top: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColors.primaryColor.withOpacity(0.3),
                      MyColors.secondaryColor.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                      color: MyColors.greyColor.withOpacity(0.5),
                    ),
                  ],
                ),
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/awareness-information-image.png',
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'اكتشفي أهمية اللقاحات',
                            style: MyTextStyles.font14WhiteBold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'للحفاظ على صحة عائلتك.',
                            style: MyTextStyles.font16WhiteBold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return FutureBuilder(
                  future: aic.fetchDataFuture.value,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: Get.width,
                        height: 300,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: ApiExceptionWidgets().mySnapshotError(
                            snapshot.error, onPressedRefresh: () {
                          aic.fetchAwarenessInfo();
                        }),
                      );
                    } else {
                      if (aic.awarenessInfo.isEmpty) {
                        return ApiExceptionWidgets().myDataNotFound(
                          onPressedRefresh: () {
                            aic.fetchAwarenessInfo();
                          },
                        );
                      } else {
                        return myAwarenessListView(
                          items: aic.awarenessInfo,
                        );
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
