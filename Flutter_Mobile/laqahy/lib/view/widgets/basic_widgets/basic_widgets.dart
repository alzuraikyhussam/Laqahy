import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

myAppBar({
  String? text,
}) {
  return AppBar(
    leading: Icon(
      Icons.arrow_back_ios_new_rounded,
      color: MyColors.blackColor,
    ),
    centerTitle: true,
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
  required String? labelText,
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
      maxLines: 3,
      minLines: 1,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      textAlign: TextAlign.end,
      textDirection: TextDirection.ltr,
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
        labelText: labelText,
        labelStyle: MyTextStyles.font14GreyMedium,
        floatingLabelStyle: MyTextStyles.font16PrimaryBold,
      ),
    ),
  );
}

myMiniButton({
  IconData? icon,
  required void Function()? onPressed,
  Color? backgroundColor,
}) {
  return Container(
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
    child: FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      splashColor: MyColors.primaryColor,
      hoverColor: MyColors.primaryColor,
      focusColor: MyColors.primaryColor,
      elevation: 0,
      child: Icon(
        icon ?? Icons.arrow_back_ios_new_rounded,
        color: MyColors.whiteColor,
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
  required String? desc,
  required void Function()? btnOkOnPress,
  String? btnOkText,
  String? btnCancelText,
  IconData? headerIcon,
}) {
  return AwesomeDialog(
    context: context,
    // dialogType: dialogType,
    animType: AnimType.scale,
    title: title,
    desc: desc,
    alignment: AlignmentDirectional.center,
    btnOk: myButton(
      onPressed: btnOkOnPress,
      text: btnOkText ?? 'موافــق',
      textStyle: MyTextStyles.font14WhiteBold,
    ),
    btnCancel: myButton(
      onPressed: () {
        Get.back();
      },
      text: btnCancelText ?? 'إلغــاء الأمــر',
      textStyle: MyTextStyles.font14WhiteBold,
      backgroundColor: MyColors.greyColor,
    ),
    customHeader: myCircleAvatar(
      icon: headerIcon,
    ),
    reverseBtnOrder: true,
    titleTextStyle: MyTextStyles.font16BlackBold,
    descTextStyle: MyTextStyles.font14GreyMedium,
    dialogBorderRadius: BorderRadiusDirectional.circular(10),
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
  ).show();
}
