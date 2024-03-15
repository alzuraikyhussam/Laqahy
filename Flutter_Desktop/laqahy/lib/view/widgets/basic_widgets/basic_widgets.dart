// import 'package:awesome_dialog/awesome_dialog.dart';
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
