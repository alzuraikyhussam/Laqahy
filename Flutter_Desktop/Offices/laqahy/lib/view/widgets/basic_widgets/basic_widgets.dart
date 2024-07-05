import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/orders/reject_confirm_alert.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

myButton({
  required void Function()? onPressed,
  required String text,
  required TextStyle? textStyle,
  double? width,
  Color? backgroundColor,
}) {
  return Container(
    width: width?.toDouble(),
    height: 50.toDouble(),
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
        textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: true,
          applyHeightToLastDescent: false,
        ),
        style: textStyle,
      ),
    ),
  );
}

myTextField({
  double? width,
  required String? hintText,
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
  TextAlign textAlign = TextAlign.start,
  String? initialValue,
  double? heightFactor = 2.7,
  void Function()? onTap,
  void Function()? onTapSuffixIcon,
  bool autofocus = false,
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
      // textDirection: TextDirection.rtl,
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
        fillColor: fillColor != null
            ? fillColor.withOpacity(0.2)
            : MyColors.whiteColor.withOpacity(0.5),
        hintText: hintText,
        hintStyle: MyTextStyles.font14GreyMedium,
      ),
    ),
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

myCopyRightText() {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 15,
    child: Text(
      textAlign: TextAlign.center,
      'جميع الحقوق محفوظة لدى فريق سورس تك ${DateTime.now().year} ©',
      style: MyTextStyles.font14GreyBold.copyWith(
        color: MyColors.greyColor.withOpacity(0.5),
      ),
    ),
  );
}

myBackgroundWindows() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
      ),
    ),
  );
}

myAppBarLogo({
  double? width = 220,
}) {
  return Image.asset(
    'assets/images/window-logo.png',
    width: width,
  );
}

exitButton() {
  return InkWell(
    onTap: () {
      exit(0);
    },
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.redColor,
        boxShadow: [
          BoxShadow(
            color: MyColors.greyColor.withOpacity(0.3),
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Icon(
        Icons.power_settings_new_rounded,
        color: MyColors.whiteColor,
        size: 28,
      ),
    ),
  );
}

goBackButton({
  required void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        // textDirection: TextDirection.ltr,
        color: MyColors.greyColor,
        size: 25,
      ),
    ),
  );
}

myHomeLayoutItems({
  required image,
  required label,
}) {
  return Row(
    children: [
      image,
      const SizedBox(
        width: 20,
      ),
      label,
    ],
  );
}

myIconButton({
  required IconData? icon,
  required void Function()? onTap,
  required List<Color> gradientColors,
  EdgeInsetsGeometry? padding = const EdgeInsets.all(10),
  double borderRadius = 10,
  double iconSize = 25,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
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
        borderRadius: BorderRadiusDirectional.circular(borderRadius.toDouble()),
      ),
      child: Icon(
        icon,
        color: MyColors.whiteColor,
        size: iconSize.toDouble(),
      ),
    ),
  );

  // return InkWell(
  //   onTap: onTap,
  //   child: Container(
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: gradientColors,
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
  //     child: Icon(
  //       icon,
  //       color: MyColors.whiteColor,
  //       size: 25,
  //     ),
  //   ),
  // );
}

myHomeCards({
  required String imagePath,
  required String title,
  required int count,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: MyColors.greyColor.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.2),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 60,
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            // width: 40,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: MyTextStyles.font16BlackBold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  // '$count',
                  Constants().decimalFormatter.format(count).toString(),
                  style: MyTextStyles.font18BlackBold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

myAlertDialog({
  required BuildContext context,
  required String title,
  required String text,
  required String image,
  required void Function()? onConfirmBtnTap,
  required void Function()? onCancelBtnTap,
  Color? confirmBtnColor,
  Color? cancelBtnColor,
  required String confirmBtnText,
  required String cancelBtnText,
}) {
  return Alert(
    onWillPopActive: true,
    closeIcon: const SizedBox(),
    padding: const EdgeInsets.all(30),
    context: context,
    content: Container(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: MyTextStyles.font18BlackBold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: MyTextStyles.font18BlackMedium,
          ),
        ],
      ),
    ),
    buttons: [
      DialogButton(
        color: confirmBtnColor,
        gradient: confirmBtnColor == null
            ? LinearGradient(
                colors: [
                  MyColors.primaryColor,
                  MyColors.secondaryColor,
                ],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              )
            : null,
        radius: BorderRadius.circular(10),
        height: 50.0,
        onPressed: onConfirmBtnTap,
        child: Text(
          confirmBtnText,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: true,
            applyHeightToLastDescent: false,
          ),
          style: MyTextStyles.font14WhiteBold,
        ),
      ),
      DialogButton(
        color: cancelBtnColor ?? MyColors.greyColor,
        radius: BorderRadius.circular(10),
        height: 50.0,
        onPressed: onCancelBtnTap,
        child: Text(
          cancelBtnText,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: true,
            applyHeightToLastDescent: false,
          ),
          style: MyTextStyles.font14WhiteBold,
        ),
      ),
    ],
  ).show();
}

myDropDownMenuButton({
  required String hintText,
  required List<String> items,
  required void Function(String?)? onChanged,
  required TextEditingController? searchController,
  required String? selectedValue,
  double? width,
  String? Function(String?)? validator,
}) {
  return Container(
    width: width != null ? width.toDouble() : 200,
    child: DropdownButtonFormField2<String>(
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
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: MyTextStyles.font16BlackMedium,
                ),
              ))
          .toList(),
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
          return item.value.toString().contains(searchValue);
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

myCheckBox({
  required void Function()? onTap,
  required void Function(bool) onChanged,
  required bool value,
  required String text,
  double? width = 150,
}) {
  return Container(
    width: width,
    child: ListTile(
      onTap: onTap,
      minLeadingWidth: 15,
      leading: MSHCheckbox(
        size: 20,
        checkedColor: MyColors.secondaryColor,
        uncheckedColor: MyColors.greyColor,
        value: value,
        colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
          checkedColor: MyColors.primaryColor,
        ),
        style: MSHCheckboxStyle.stroke,
        onChanged: onChanged,
      ),
      title: Text(
        text,
        style: MyTextStyles.font16BlackBold,
      ),
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

myOrdersItem({
  int? id,
  String? officeName,
  String? centerName,
  required String vaccineType,
  String? orderState,
  required var date,
  required String note,
  required int quantity,
  double? height = 250,
}) {
  OrdersController oc = Get.put(OrdersController());
  return Container(
    padding: const EdgeInsets.all(25),
    height: height,
    decoration: BoxDecoration(
      // color: Colors.white.withOpacity(0.9),
      border: Border.all(
        color: MyColors.greyColor.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.2),
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    orderState == 'outgoing' || orderState == 'rejected'
                        ? 'اسم المكتب:'
                        : 'اسم المركز:',
                    style: MyTextStyles.font16PrimaryBold,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      orderState == 'outgoing' || orderState == 'rejected'
                          ? officeName ?? 'غير معروف'
                          : centerName ?? 'غير معروف',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: MyTextStyles.font16BlackBold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'اسم اللقــاح:',
                    style: MyTextStyles.font16PrimaryBold,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      vaccineType,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: MyTextStyles.font16BlackBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'الكميــة:',
              style: MyTextStyles.font16PrimaryBold,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              quantity.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: MyTextStyles.font16BlackBold,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderState == 'incoming'
                  ? 'ملاحظة المركز:'
                  : orderState == 'outgoing'
                      ? 'ملاحظة المكتب:'
                      : orderState == 'rejected'
                          ? 'سبب الرفض:'
                          : 'ملاحظة الوزارة:',
              overflow: TextOverflow.ellipsis,
              style: MyTextStyles.font16PrimaryBold,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                note,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: MyTextStyles.font16BlackBold,
              ),
            ),
          ],
        ),
        const Spacer(),
        orderState == 'in_delivery'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: MyColors.greyColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      'لقد تم قبول طلبكم من قبل الوزارة الرجاء النقر على زر تأكبد الاستلام عند وصول الطلب إليكم.',
                      style: MyTextStyles.font14GreyBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        MyColors.primaryColor,
                        MyColors.secondaryColor,
                      ],
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                    ),
                  ),
                  child: Icon(
                    Icons.av_timer_rounded,
                    color: MyColors.whiteColor,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  date,
                  style: MyTextStyles.font16GreyBold,
                ),
              ],
            ),
            orderState == 'incoming'
                ? Row(
                    children: [
                      Obx(() {
                        return oc.isApprovalLoading.value
                            ? myLoadingIndicator(width: 150)
                            : myButton(
                                width: 150,
                                onPressed: () async {
                                  await oc.approvalCenterOrder(orderId: id!);
                                },
                                text: 'موافقــة',
                                textStyle: MyTextStyles.font16WhiteBold,
                              );
                      }),
                      const SizedBox(
                        width: 20,
                      ),
                      myButton(
                          width: 150,
                          backgroundColor: MyColors.redColor,
                          onPressed: () {
                            myShowDialog(
                                context: Get.context!,
                                widgetName: RejectConfirmAlert(
                                  id: id!,
                                ));
                          },
                          text: 'رفـــض',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ],
                  )
                : orderState == 'in_delivery'
                    ? Obx(() {
                        return oc.isApprovalLoading.value
                            ? myLoadingIndicator()
                            : myButton(
                                // width: 180,
                                onPressed: () async {
                                  await oc.receivingOrderConfirm(orderId: id!);
                                },
                                text: 'تأكيــد اســتلام الطلــب',
                                textStyle: MyTextStyles.font16WhiteBold,
                              );
                      })
                    : const SizedBox(),
          ],
        ),
      ],
    ),
  );
}

myReportsCards({
  required String imageName,
  required String title,
  required void Function()? onPressed,
  required context,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: MyColors.greyColor.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.2),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            imageName,
            fit: BoxFit.cover,
            width: 40,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: MyTextStyles.font18BlackBold,
        ),
        const SizedBox(
          height: 20,
        ),
        myButton(
          width: 120,
          onPressed: onPressed,
          text: 'إنـــشـــــــاء',
          textStyle: MyTextStyles.font14WhiteBold,
        ),
      ],
    ),
  );
}

myLoadingIndicator({
  double height = 50,
  double width = 130,
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

myVaccineCards({
  String title = 'unknown',
  int quantity = 0,
  required int id,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: MyColors.greyColor.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.2),
          blurRadius: 10,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Get.height,
          width: 90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/vaccines-icon.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لقـاح $title',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: MyTextStyles.font16PrimaryBold,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$quantity',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: MyTextStyles.font18BlackBold,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
