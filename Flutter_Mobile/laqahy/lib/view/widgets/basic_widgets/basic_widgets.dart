import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

myAppBar({
  String? text,
  bool showBackButton = true,
  void Function()? onTap,
}) {
  return AppBar(
    elevation: 0,
    leading: showBackButton
        ? InkWell(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.blackColor,
            ),
          )
        : null,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: text != null
        ? Text(
            textHeightBehavior: TextHeightBehavior(
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
          offset: Offset(0, 4),
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
  required void Function()? onPressed,
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
            offset: Offset(0, 4),
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
  TextAlign textAlign = TextAlign.right,
  void Function()? onTap,
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
      onTap: onTap,
      controller: controller,
      cursorColor: MyColors.primaryColor.withOpacity(0.7),
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: obscureText
          ? 1
          : maxLines == null
              ? 1
              : maxLines,
      // minLines: minLines != null ? minLines : 1,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
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
                  widthFactor: 1.0,
                  heightFactor: 3.0,
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
                onTap: () {},
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
        contentPadding: EdgeInsetsDirectional.all(18),
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

myCarouselSlider() {
  return CarouselSlider.builder(
    itemCount: 3,
    options: CarouselOptions(
      height: 220,
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
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: 500,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     MyColors.primaryColor,
            //     MyColors.secondaryColor,
            //   ],
            //   begin: AlignmentDirectional.topCenter,
            //   end: AlignmentDirectional.bottomCenter,
            // ),
            borderRadius: BorderRadius.circular(12),
          ),
          // child: Text(snapshot.data[itemIndex].urlToImage),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ShadowOverlay(
                shadowWidth: 800,
                shadowHeight: 200,
                shadowColor: Colors.black.withOpacity(0.3),
                child: Image.asset(
                  'assets/images/carousel-image.png',
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
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 30,
                  end: 30,
                  bottom: 25,
                ),
                child: Text(
                  'مع تطبيق لقاحي ... \nللتطعيم منظور مختلف',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

// myMiniButton({
//   IconData? icon,
//   required void Function()? onPressed,
//   Color? backgroundColor,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           MyColors.primaryColor,
//           MyColors.secondaryColor,
//         ],
//         begin: AlignmentDirectional.topCenter,
//         end: AlignmentDirectional.bottomCenter,
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: MyColors.greyColor.withOpacity(0.3),
//           blurRadius: 4,
//           offset: Offset(0, 4),
//           spreadRadius: 0,
//         ),
//       ],
//       borderRadius: BorderRadiusDirectional.circular(10),
//     ),
//     child: FloatingActionButton(
//       onPressed: onPressed,
//       backgroundColor: backgroundColor ?? Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusDirectional.circular(10),
//       ),
//       splashColor: MyColors.primaryColor,
//       hoverColor: MyColors.primaryColor,
//       focusColor: MyColors.primaryColor,
//       elevation: 0,
//       child: Icon(
//         icon ?? Icons.arrow_back_ios_new_rounded,
//         color: MyColors.whiteColor,
//       ),
//     ),
//   );
// }

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
          textDirection: TextDirection.ltr,
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

myAwesomeDialog({
  required BuildContext context,
  DialogType dialogType = DialogType.info,
  required String? title,
  bool showBtnCancel = true,
  required String? desc,
  required void Function()? btnOkOnPress,
  String? btnOkText,
  String? btnCancelText,
  IconData? headerIcon,
  bool dismissOnBackKeyPress = true,
  bool dismissOnTouchOutside = true,
}) {
  return AwesomeDialog(
    context: context,
    // dialogType: dialogType,
    animType: AnimType.scale,
    title: title,
    desc: desc,
    padding: EdgeInsetsDirectional.only(
      top: 15,
      bottom: 15,
      start: 10,
      end: 10,
    ),
    alignment: AlignmentDirectional.center,
    btnOk: myButton(
      onPressed: btnOkOnPress,
      text: btnOkText ?? 'موافــق',
      textStyle: MyTextStyles.font14WhiteBold,
    ),
    btnCancel: showBtnCancel
        ? myButton(
            onPressed: () {
              Get.back();
            },
            text: btnCancelText ?? 'إلغــاء الأمــر',
            textStyle: MyTextStyles.font14WhiteBold,
            backgroundColor: MyColors.greyColor,
          )
        : null,
    customHeader: myCircleAvatar(
      icon: headerIcon,
    ),
    reverseBtnOrder: true,
    titleTextStyle: MyTextStyles.font16BlackBold,
    descTextStyle: MyTextStyles.font14GreyMedium,
    dialogBorderRadius: BorderRadiusDirectional.circular(10),
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    dismissOnTouchOutside: dismissOnTouchOutside,
  ).show();
}
