import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class FirstOnboarding extends StatefulWidget {
  const FirstOnboarding({super.key});

  @override
  State<FirstOnboarding> createState() => _FirstOnboardingState();
}

class _FirstOnboardingState extends State<FirstOnboarding> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

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
                  'assets/images/first-onboarding.svg',
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
                    'احصلي على تذكيرات بمواعيد اللقاحات لك ولطفلك.',
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
