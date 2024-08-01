import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:laqahy/controllers/settings_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/awareness_info_model.dart';
import 'package:laqahy/models/notifications_model.dart';
import 'package:laqahy/models/post_model.dart';
import 'package:laqahy/models/settings_model.dart';
import 'package:laqahy/view/screens/awareness_info/awareness_info_details.dart';
import 'package:laqahy/view/screens/login/login.dart';
import 'package:laqahy/view/screens/posts/post_details.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

myAppBar({
  String? text,
  bool showBackButton = true,
  void Function()? onTap,
  Color? backgroundColor,
  Color? iconColor,
}) {
  return AppBar(
    elevation: 0,
    leading: showBackButton
        ? InkWell(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: iconColor ?? MyColors.blackColor,
            ),
          )
        : null,
    centerTitle: true,
    backgroundColor: backgroundColor ?? Colors.white,
    title: text != null
        ? Text(
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: true,
              applyHeightToLastDescent: false,
            ),
            text,
            style: MyTextStyles.font18BlackBold,
          )
        : null,
  );
}

myButton({
  required void Function()? onPressed,
  required String text,
  required TextStyle? textStyle,
  double? width,
  Color? backgroundColor,
}) {
  return Container(
    width: width?.toDouble(),
    height: 55.toDouble(),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          MyColors.primaryColor,
          MyColors.secondaryColor,
        ],
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
      borderRadius: BorderRadiusDirectional.circular(10),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    ),
  );
}

myIconButton({
  double? width = 60,
  required IconData? icon,
  List<Color>? backgroundColor,
  required void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: AlignmentDirectional.center,
      width: width,
      height: 55.toDouble(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor ??
              [
                MyColors.primaryColor,
                MyColors.secondaryColor,
              ],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColors.greyColor.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Icon(
        icon,
        size: 30,
        color: MyColors.whiteColor,
      ),
    ),
  );
}

myTextField({
  double? width,
  required String? labelText,
  TextEditingController? controller,
  required TextInputType? keyboardType,
  int? maxLength,
  bool obscureText = false,
  required void Function(String)? onChanged,
  bool readOnly = false,
  String? Function(String?)? validator,
  IconData? prefixIcon,
  String? prefixImage,
  IconData? suffixIcon,
  String? suffixImage,
  Color? color,
  int? maxLines,
  Color? fillColor,
  TextAlign textAlign = TextAlign.end,
  String? initialValue,
  double? heightFactor = 2.7,
  void Function()? onTap,
  void Function()? onTapSuffixIcon,
  bool autofocus = false,
  // double? width,
  // required String? labelText,
  // TextEditingController? controller,
  // required TextInputType? keyboardType,
  // int? maxLength,
  // bool obscureText = false,
  // required void Function(String)? onChanged,
  // bool readOnly = false,
  // String? Function(String?)? validator,
  // IconData? prefixIcon,
  // String? prefixImage,
  // IconData? suffixIcon,
  // String? suffixImage,
  // Color? color,
  // int? maxLines,
  // Color? fillColor,
  // TextAlign textAlign = TextAlign.right,
  // void Function()? onTap,
  // void Function()? onTapSuffixIcon,
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
      autofocus: autofocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      initialValue: initialValue,
      controller: controller,
      cursorColor: MyColors.primaryColor.withOpacity(0.7),
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : maxLines ?? 1,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      textDirection: ui.TextDirection.ltr,
      validator: validator,
      textAlign: textAlign,
      style: MyTextStyles.font16BlackMedium,
      decoration: InputDecoration(
        counterStyle: MyTextStyles.font14GreyBold.copyWith(
          color: MyColors.greyColor.withOpacity(0.5),
        ),
        prefixIcon: prefixIcon != null && maxLines != null
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  widthFactor: 1.5,
                  heightFactor: heightFactor,
                  child: Icon(
                    prefixIcon,
                    color: MyColors.greyColor.withOpacity(0.8),
                  ),
                ),
              )
            : Icon(
                prefixIcon,
                color: MyColors.greyColor.withOpacity(0.8),
              ),
        prefix: prefixImage != null
            ? Image.asset(
                prefixImage,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onTapSuffixIcon,
                child: Icon(
                  suffixIcon,
                  color: MyColors.greyColor.withOpacity(0.8),
                ),
              )
            : null,
        suffix: suffixImage != null
            ? InkWell(
                onTap: () {},
                child: Image.asset(
                  suffixImage,
                ),
              )
            : null,
        contentPadding: const EdgeInsetsDirectional.all(18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.greyColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.greyColor.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.redColor,
          ),
        ),
        filled: true,
        fillColor: MyColors.whiteColor.withOpacity(0.5),
        labelText: labelText,
        labelStyle: MyTextStyles.font14GreyMedium,
        floatingLabelStyle: MyTextStyles.font16PrimaryBold,
      ),
    ),
  );
}

myPostsCarouselSlider({
  required List<Post> post,
}) {
  return CarouselSlider.builder(
    itemCount: post.length,
    options: CarouselOptions(
      height: 200,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
    ),
    itemBuilder: (context, itemIndex, pageViewIndex) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: 500,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.primaryColor,
                MyColors.secondaryColor,
              ]),
              borderRadius: BorderRadius.circular(12)),
          // child: Text(snapshot.data[itemIndex].urlToImage),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ShadowOverlay(
                shadowWidth: 800,
                shadowHeight: 200,
                shadowColor: Colors.black.withOpacity(0.7),
                child: Image.network(
                  post[itemIndex].postImage,
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
              Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                  end: 15,
                  bottom: 20,
                  top: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 5,
                        vertical: 2,
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
                        style: MyTextStyles.font14WhiteMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      post[itemIndex].postTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

mySettingsListView({
  required List<SettingsListItem> items,
}) {
  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(15),
    // physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return ListTile(
        splashColor: MyColors.greyColor,
        hoverColor: MyColors.greyColor,
        onTap: items[index].onTap,
        leading: items[index].prefix,
        title: Text(
          items[index].label,
        ),
        trailing: items[index].suffix,
      );
    },
    separatorBuilder: (context, index) {
      return Divider(
        thickness: 0.5,
        color: MyColors.greyColor,
        indent: 10,
        endIndent: 10,
      );
    },
    itemCount: items.length,
  );
}

myAwarenessListView({
  required List<AwarenessInformation> items,
}) {
  return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Get.to(
            () => AwarenessInfoDetailsScreen(
              title: items[index].title,
              description: items[index].description,
            ),
          );
        },
        child: Card(
          child: Container(
            width: Get.width,
            // height: 161,
            padding: const EdgeInsetsDirectional.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  // height: Get.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      Text(
                        items[index].title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        items[index].description,
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font14GreyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      height: 10,
    ),
    itemCount: items.length,
  );
}

myNotificationsListView({
  required List<Notifications> notification,
}) {
  return ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsetsDirectional.only(
      top: 10,
      bottom: 15,
      start: 15,
      end: 15,
    ),
    itemBuilder: (context, index) {
      return Card(
        child: Container(
          height: 120,
          padding: const EdgeInsetsDirectional.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: MyColors.primaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification[index].title,
                            style: MyTextStyles.font14BlackBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                notification[index].description,
                                style: MyTextStyles.font14GreyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(notification[index].date)
                              .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: MyTextStyles.font14GreyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, index) {
      return const SizedBox(
        height: 10,
      );
    },
    itemCount: notification.length,
  );
}

myPostsListView({
  required List<Post> post,
}) {
  return ListView.separated(
    padding: EdgeInsets.zero,
    itemCount: post.length,
    separatorBuilder: (context, index) => const SizedBox(
      height: 10,
    ),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Get.to(
            () => PostDetailsScreen(
              image: post[index].postImage,
              title: post[index].postTitle,
              description: post[index].postDescription,
              publishedAt: DateFormat('EE yyyy-MM-dd')
                  .format(post[index].postPublishDate!)
                  .toString(),
            ),
          );
        },
        child: Card(
          child: Container(
            width: Get.width,
            // height: 400,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyColors.primaryColor,
                        MyColors.secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    post[index].postImage,
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
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
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
                        post[index].postTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        post[index].postDescription,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font14GreyMedium,
                      ),
                      const SizedBox(
                        height: 10,
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
                            DateFormat('EE yyyy-MM-dd')
                                .format(post[index].postPublishDate!)
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: MyTextStyles.font14GreyMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

myCarouselSlider() {
  return CarouselSlider.builder(
    itemCount: Constants().carouselSliderImages.length,
    options: CarouselOptions(
      height: 200,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
    ),
    itemBuilder: (context, itemIndex, pageViewIndex) {
      return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        // child: Text(snapshot.data[itemIndex].urlToImage),
        child: Image.asset(
          Constants().carouselSliderImages[itemIndex],
          // 'https://www.cnet.com/a/img/resize/d88681c50c779bd709963793f699ca17147fccf4/hub/2023/09/13/1530496f-a39e-4127-b47b-4d88cb37d510/p1020938-1.jpg?auto=webp&fit=crop&height=675&width=1200',
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover,
          height: Get.height,
          width: Get.width,
          // errorBuilder: (BuildContext context, Object exception,
          //     StackTrace? stackTrace) {
          //   if (exception is SocketException) {
          //     // Handle the SocketException
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   } else {
          //     // Handle other types of image errors
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   }
          // },
        ),
      );
    },
  );
}

myTextButton({
  required String text,
  required void Function()? onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      alignment: AlignmentDirectional.centerStart,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
    ),
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: MyTextStyles.font14SecondaryBold,
    ),
  );
}

myCircleAvatar({
  Color? backgroundColor,
  IconData? icon,
  Color? iconColor,
  double? radius,
}) {
  return CircleAvatar(
    radius: radius != null ? radius.toDouble() : 50.toDouble(),
    backgroundColor: backgroundColor != null
        ? backgroundColor.withOpacity(0.2)
        : MyColors.secondaryColor.withOpacity(0.2),
    child: Icon(
      icon ?? Icons.check_rounded,
      color: iconColor ?? MyColors.secondaryColor,
      size: 50,
    ),
  );
}

myListTile({
  required void Function()? onTap,
  Color? backgroundColor,
  required IconData? icon,
  Color? iconColor,
  required String title,
  required String subtitle,
  Widget? trailing,
}) {
  return ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: backgroundColor != null
          ? backgroundColor.withOpacity(0.2)
          : MyColors.secondaryColor.withOpacity(0.2),
      child: Icon(
        icon,
        color: iconColor ?? MyColors.secondaryColor,
      ),
    ),
    title: Text(
      title,
      style: MyTextStyles.font14BlackBold,
    ),
    trailing: trailing ??
        Icon(
          Icons.arrow_back_ios_new_rounded,
          textDirection: ui.TextDirection.ltr,
          color: MyColors.greyColor,
        ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(10),
    ),
    subtitle: Text(
      subtitle,
      style: MyTextStyles.font14GreyMedium,
    ),
  );
}

myShowDialog({
  required BuildContext context,
  required widgetName,
  bool barrierDismissible = false,
}) {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return widgetName;
    },
  );
}

myProfileListTile({
  required IconData icon,
  required String label,
  required String value,
  TextStyle? style,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: MyColors.primaryColor,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 7,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.primaryColor,
                MyColors.secondaryColor,
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            style: MyTextStyles.font14WhiteBold,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              value,
              style: style ?? MyTextStyles.font16BlackBold,
            ),
          ),
        ),
      ],
    ),
  );
}

// StaticDataController sdc = Get.put(StaticDataController());

// mySwitchButton() {
//   return Obx(() {
//     return CupertinoSwitch(
//       activeColor: MyColors.primaryColor,
//       trackColor: MyColors.primaryColor.withOpacity(0.2),
//       value: sdc.isDark.value,
//       onChanged: (val) {
//         sdc.toggleTheme();
//       },
//     );
//   });
// }

myLoadingIndicator({
  double height = 50,
  double width = 120,
}) {
  return Container(
    padding: const EdgeInsetsDirectional.all(10),
    height: height.toDouble(),
    width: width.toDouble(),
    alignment: AlignmentDirectional.center,
    child: LoadingIndicator(
      indicatorType: Indicator.lineScale,

      /// Required, The loading type of the widget
      colors: [
        MyColors.secondaryColor,
        MyColors.primaryColor,
      ],

      /// Optional, The color collections
      strokeWidth: 2,

      /// Optional, The stroke of the line, only applicable to widget which contains line
      // backgroundColor: Colors.black,

      /// Optional, Background of the widget
      // pathBackgroundColor: Colors.black,

      /// Optional, the stroke backgroundColor
    ),
  );
}

Widget myDropDownMenuButton2<T>({
  required String hintText,
  required List<DropdownMenuItem<T>>? items,
  required void Function(T?)? onChanged,
  required TextEditingController? searchController,
  required T? selectedValue,
  double? width,
  String? Function(T?)? validator,
}) {
  return SizedBox(
    width: width != null ? width.toDouble() : 200,
    child: DropdownButtonFormField2<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.whiteColor.withOpacity(0.5),
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.greyColor.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.primaryColor.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: MyColors.redColor,
          ),
        ),
      ),
      validator: validator,
      isExpanded: true,
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: 14,
          color: MyColors.greyColor,
        ),
      ),

      items: items,
      value: selectedValue,
      onChanged: onChanged,
      buttonStyleData: ButtonStyleData(
        padding: const EdgeInsets.all(12),
        height: 60,
        width: width != null ? width.toDouble() : 200,
        decoration: BoxDecoration(
          // color: MyColors.whiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: MyColors.greyColor.withOpacity(0.3),
          // ),
        ),
      ),

      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        maxHeight: 150,
        width: width,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 44,
      ),

      dropdownSearchData: DropdownSearchData(
        searchController: searchController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: searchController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'ابـحــث هنــا',
              hintStyle: MyTextStyles.font14GreyMedium,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: MyColors.greyColor.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: MyColors.greyColor.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: MyColors.primaryColor.withOpacity(0.5),
                ),
              ),
              filled: true,
              fillColor: MyColors.whiteColor.withOpacity(0.5),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          // return item.value.toString().contains(searchValue);
          return item.child.toString().contains(searchValue);
        },
      ),

      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchController?.clear();
        }
      },
    ),
  );
}

myLogoutConfirmDialog() {
  return AlertDialog(
    alignment: AlignmentDirectional.center,
    actionsAlignment: MainAxisAlignment.center,
    content: SizedBox(
      height: 225,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: Get.width,
              child: Lottie.asset(
                'assets/images/question.json',

                // alignment: Alignment.center,
                // fit: BoxFit.cover,
              ),
              // Image.asset(
              //   widget.imageUrl,
              //   width: 130,
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تأكيد تسجيل الخروج',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Text(
                    'هل انتِ متأكدة من عملية تسجيل الخروج؟',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTextStyles.font14GreyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      myButton(
        backgroundColor: MyColors.redColor,
        onPressed: () async {
          Get.offAll(() => const LoginScreen());
          await Get.closeCurrentSnackbar();
          Get.delete<SettingsController>();
        },
        text: 'تسجيل خروج',
        textStyle: MyTextStyles.font14WhiteBold,
      ),
    ],
  );
}

Future<bool> myExitAppConfirmDialog(context) async {
  return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: AlignmentDirectional.center,
            actionsAlignment: MainAxisAlignment.center,
            content: SizedBox(
              height: 240,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: Get.width,
                      child: Lottie.asset(
                        'assets/images/question.json',

                        // alignment: Alignment.center,
                        // fit: BoxFit.cover,
                      ),
                      // Image.asset(
                      //   widget.imageUrl,
                      //   width: 130,
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تأكيد الخروج',
                          style: MyTextStyles.font16BlackBold,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Text(
                            'هل انتِ متأكدة من عملية الخروج من التطبيق؟',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyles.font14GreyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              myButton(
                backgroundColor: MyColors.redColor,
                onPressed: () async {
                  Get.back(result: true);
                },
                text: 'نعم، خروج',
                textStyle: MyTextStyles.font14WhiteBold,
              ),
            ],
          );
        },
      ) ??
      false;
}
