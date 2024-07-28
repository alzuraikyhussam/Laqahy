import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ApiExceptionAlert extends StatefulWidget {
  ApiExceptionAlert({
    super.key,
    required this.title,
    required this.description,
    this.height = 320,
    this.imageUrl = 'assets/images/error.json',
    this.backgroundColor,
    this.onPressed,
    this.onCancelPressed,
    this.btnLabel = 'مــوافق',
  });

  String title, description, imageUrl;
  double height;
  Color? backgroundColor;
  String btnLabel;
  void Function()? onPressed;
  void Function()? onCancelPressed;

  @override
  State<ApiExceptionAlert> createState() => _ApiExceptionAlertState();
}

class _ApiExceptionAlertState extends State<ApiExceptionAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        padding: const EdgeInsetsDirectional.only(
          top: 20,
        ),
        height: widget.height.toDouble(),
        width: 350,
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 150,
                width: Get.width,
                child: Lottie.asset(
                  widget.imageUrl,

                  alignment: Alignment.center,
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
                  widget.title,
                  style: MyTextStyles.font18BlackBold,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    widget.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: MyTextStyles.font16GreyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      actions: widget.onCancelPressed == null
          ? [
              myButton(
                onPressed: widget.onPressed ??
                    () {
                      Get.back();
                    },
                width: 150,
                backgroundColor: widget.backgroundColor ?? MyColors.redColor,
                text: widget.btnLabel,
                textStyle: MyTextStyles.font16WhiteBold,
              ),
            ]
          : [
              myButton(
                onPressed: widget.onPressed ??
                    () {
                      Get.back();
                    },
                backgroundColor: widget.backgroundColor ?? MyColors.redColor,
                text: widget.btnLabel,
                textStyle: MyTextStyles.font16WhiteBold,
                width: 150,
              ),
              myButton(
                onPressed: widget.onCancelPressed,
                backgroundColor: MyColors.greyColor,
                text: 'إلغــاء الأمــر',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 150,
              ),
            ],
    );
  }
}
