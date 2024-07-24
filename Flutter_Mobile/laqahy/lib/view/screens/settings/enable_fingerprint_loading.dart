import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class EnableFingerprintLoading extends StatefulWidget {
  const EnableFingerprintLoading({super.key});

  @override
  State<EnableFingerprintLoading> createState() =>
      _EnableFingerprintLoadingState();
}

class _EnableFingerprintLoadingState extends State<EnableFingerprintLoading> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(
                Icons.fingerprint_rounded,
                color: MyColors.primaryColor,
                size: 70,
              ),
            ),
            myLoadingIndicator(height: 50),
          ],
        ),
      ),
    );
  }
}
