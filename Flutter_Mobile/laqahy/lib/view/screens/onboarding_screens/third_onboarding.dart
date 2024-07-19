import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class ThirdOnboarding extends StatefulWidget {
  const ThirdOnboarding({super.key});

  @override
  State<ThirdOnboarding> createState() => _ThirdOnboardingState();
}

class _ThirdOnboardingState extends State<ThirdOnboarding> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(40),
                child: SvgPicture.asset(
                  'assets/images/third-onboarding.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40),
              height: 220,
              width: width,
              decoration: BoxDecoration(
                color: MyColors.whiteColor.withOpacity(0.5),
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(50),
                  topEnd: Radius.circular(50),
                ),
                border: Border.all(
                  color: MyColors.greyColor.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.greyColor.withOpacity(0.1),
                    offset: const Offset(10, 0),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'كوني على استعداد دائم للحماية من الأمراض المعدية.',
                    style: MyTextStyles.font18BlackBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
