// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

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
  IconData? suffixIcon,
  Color? color,
  int? minLines,
}) {
  return SizedBox(
    width: width?.toDouble(),
    child: TextFormField(
      controller: controller,
      cursorColor: MyColors.primaryColor,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: obscureText ? 1 : 3,
      minLines: minLines != null ? minLines : 1,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      textAlign: TextAlign.start,
      textDirection: TextDirection.rtl,
      style: MyTextStyles.font16BlackMedium,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyColors.greyColor,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: MyColors.greyColor,
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
        fillColor: MyColors.whiteColor,
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
  IconData? suffixIcon,
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
      textDirection: TextDirection.rtl,
      style: MyTextStyles.font16BlackMedium,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyColors.greyColor,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: MyColors.greyColor,
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
