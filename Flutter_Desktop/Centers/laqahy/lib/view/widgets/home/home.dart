import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FutureBuilder(
          future: hc.fetchDataFuture.value,
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
                child: ApiExceptionWidgets().mySnapshotError(snapshot.error,
                    onPressedRefresh: () async {
                  await hc.fetchHomeCardItems();
                }),
              );
            } else {
              if (hc.errorMsg.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/images/error.json',
                        width: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${hc.errorMsg}',
                        style: MyTextStyles.font16GreyBold,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myButton(
                        onPressed: () async {
                          await hc.fetchHomeCardItems();
                        },
                        text: 'تحـديـــث',
                        textStyle: MyTextStyles.font14WhiteBold,
                      ),
                    ],
                  ),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: hc.homeCardItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 180,
                  ),
                  itemBuilder: (context, index) {
                    return myHomeCards(
                      imagePath: hc.homeCardItems[index].imagePath!,
                      title: hc.homeCardItems[index].title!,
                      count: hc.homeCardItems[index].count!,
                    );
                  },
                );
              }
            }
          });
    });
  }
}
