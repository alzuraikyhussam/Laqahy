import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.publishedAt,
  });

  String image;
  String title;
  String description;
  String publishedAt;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: Get.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                          color: MyColors.greyColor.withOpacity(0.5),
                        ),
                      ],
                    ),
                    child: Image.network(
                      widget.image,
                      // 'https://www.cnet.com/a/img/resize/d88681c50c779bd709963793f699ca17147fccf4/hub/2023/09/13/1530496f-a39e-4127-b47b-4d88cb37d510/p1020938-1.jpg?auto=webp&fit=crop&height=675&width=1200',
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.cover,
                      height: Get.height,
                      width: Get.width,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        if (exception is SocketException) {
                          // Handle the SocketException
                          return Center(
                            child: myLoadingIndicator(),
                          );
                        } else {
                          // Handle other types of image errors
                          return Center(
                            child: myLoadingIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 5,
                    child: IconButton(
                      color: MyColors.whiteColor,
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'وزارة الصحة والسكان',
                        style: MyTextStyles.font14WhiteBold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.title,
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          size: 20,
                          color: MyColors.primaryColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.publishedAt,
                          style: MyTextStyles.font14GreyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.description,
                      style: MyTextStyles.font14GreyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
