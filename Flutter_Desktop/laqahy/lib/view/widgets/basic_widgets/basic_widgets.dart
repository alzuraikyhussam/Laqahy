// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/welcome.dart';
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
        textHeightBehavior: TextHeightBehavior(
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
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
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
      textAlign: TextAlign.start,
      // textDirection: TextDirection.rtl,
      style: MyTextStyles.font16BlackMedium,
      decoration: InputDecoration(
        counterStyle: MyTextStyles.font14GreyBold.copyWith(
          color: MyColors.greyColor.withOpacity(0.5),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyColors.greyColor.withOpacity(0.8),
              )
            : null,
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

myTextField2({
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
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
      controller: controller,
      cursorColor: MyColors.primaryColor,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : 3,
      minLines: 1,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      textAlign: TextAlign.start,
      // textDirection: TextDirection.rtl,
      style: MyTextStyles.font16BlackMedium,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyColors.greyColor,
              )
            : null,
        prefix: prefixImage != null
            ? Image.asset(
                prefixImage,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: MyColors.greyColor,
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
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: MyColors.secondaryColor.withOpacity(0.2),
        hintText: hintText,
        hintStyle: MyTextStyles.font14GreyBold,
      ),
    ),
  );
}

myCopyRightText() {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 15,
    child: Opacity(
      opacity: 0.5,
      child: Text(
        textAlign: TextAlign.center,
        'جميع الحقوق محفوظة لدى فريق سورس تك ${DateTime.now().year} ©',
        style: MyTextStyles.font14GreyBold,
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
      padding: EdgeInsets.all(5),
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
      padding: EdgeInsets.all(5),
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

myHomeLayoutAppBarButtons({
  required IconData? icon,
  required void Function()? onTap,
  required List<Color> gradientColors,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(10),
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
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Icon(
        icon,
        color: MyColors.whiteColor,
        size: 25,
      ),
    ),
  );
}

myHomeCards({
  required String imageName,
  required String title,
  required int value,
}) {
  return Container(
    padding: EdgeInsets.all(20),
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
          padding: EdgeInsets.all(10),
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
        SizedBox(
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
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  '$value',
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

myPostsCard() {
  return Container(
    padding: EdgeInsets.all(15),
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      border: Border.all(
        color: MyColors.greyColor.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: MyColors.greyColor.withOpacity(0.2),
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
          offset: Offset(0, 0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/images/default-post-image.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'لقــاح الســل',
                style: MyTextStyles.font18PrimaryBold,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  'ما هو لقاح السل؟ لقاح السل هو لقاح يستخدم للوقاية من مرض السل، وهو مرض يسببه البكتيريا المعروفة باسم ميكروب السل. كيف يعمل لقاح السل؟',
                  style: MyTextStyles.font16BlackMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${DateFormat('hh:mm yyyy-MM-dd').format(DateTime.now())}',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myButton(
                onPressed: () {},
                text: 'تعـديـل',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 100,
              ),
              myButton(
                onPressed: () {},
                text: 'حــذف',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 100,
                backgroundColor: MyColors.redColor,
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
    closeIcon: SizedBox(),
    padding: EdgeInsets.all(30),
    context: context,
    content: Container(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: MyTextStyles.font18BlackBold,
          ),
          SizedBox(
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
          textHeightBehavior: TextHeightBehavior(
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
          textHeightBehavior: TextHeightBehavior(
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
}) {
  return Center(
    child: DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
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
          padding: EdgeInsets.all(12),
          height: 53,
          width: width != null ? width.toDouble() : 200,
          decoration: BoxDecoration(
            color: MyColors.whiteColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColors.greyColor.withOpacity(0.3),
            ),
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
    ),
  );
}

myCheckBox({
  required void Function()? onTap,
  required void Function(bool) onChanged,
  required bool value,
  required String text,
}) {
  return Container(
    width: 150,
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

adminVerificationDialog({
  required BuildContext context,
}) {
  return;
}



// myDropDownButton({
//   required double? width,
//   required List<String>? items,
//   String? selectedValue,
//   IconData? buttonIcon,
//   double? buttonIconSize,
//   Color? buttonIconColor,
//   required void Function(String?)? onChanged,
//   IconData? iconStyleData,
//   double? iconStyleDataSize,
//   double? dropdownStyleDataWdith,
//   double? menuItemStyleDataHight,
// }) {
//   Container(
//     margin: const EdgeInsets.only(left: 20, top: 3),
//     width: width?.toDouble(),
//     child: DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             Icon(
//               buttonIcon,
//               size: 16,
//               color: buttonIconColor,
//             ),
//             SizedBox(
//               width: 4,
//             ),
//           ],
//         ),
//         items: items!
//             .map(
//               (String item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: MyTextStyles.font14BlackBold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             )
//             .toList(),
//         value: selectedValue,
//         onChanged: onChanged,
//         buttonStyleData: ButtonStyleData(
//           height: 50,
//           width: 160,
//           padding: const EdgeInsets.only(left: 14, right: 14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: MyColors.greyColor.withOpacity(0.3)),
//             color: MyColors.whiteColor,
//           ),
//           elevation: 0,
//         ),
//         iconStyleData: IconStyleData (
//           icon:  Icon(
//             iconStyleData,
//           ) ,

//           iconSize: iconStyleDataSize!,
//           iconEnabledColor: MyColors.greyColor,
//           iconDisabledColor: MyColors.greyColor,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 150,
//           width: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: MyColors.whiteColor,
//           ),
//           // offset: const Offset(-29, 0),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             thickness: MaterialStateProperty.all<double>(6),
//             thumbVisibility: MaterialStateProperty.all<bool>(true),
//           ),
//         ),
//         menuItemStyleData: MenuItemStyleData(
//           height: menuItemStyleDataHight!,
//           padding: const EdgeInsets.only(left: 14, right: 14),
//         ),
//       ),
//     ),
//   );
// }
