import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/setting_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
            onTap: onTap,
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
  TextAlign textAlign = TextAlign.right,
  void Function()? onTap,
  void Function()? onTapSuffixIcon,
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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

myShowDialog({
  required BuildContext context,
  required widgetName,
}) {
  return showDialog(
    barrierDismissible: false,
    barrierColor: MyColors.greyColor.withOpacity(0.5),
    context: context,
    builder: (context) {
      return widgetName;
    },
  );
}

mySwitchButton() {
  SettingController sc = Get.put(SettingController());

  return Obx(() {
    return CupertinoSwitch(
      activeColor: MyColors.primaryColor,
      trackColor: MyColors.primaryColor.withOpacity(0.2),
      value: sc.switchValue.value,
      onChanged: (val) {
        sc.switchValue.value = val;
        print(sc.switchValue);
      },
    );
  });
}

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
  return Container(
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
