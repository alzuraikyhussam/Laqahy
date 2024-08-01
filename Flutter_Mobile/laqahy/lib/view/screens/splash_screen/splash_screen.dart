import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/layouts/onboarding_layout.dart';
import 'package:laqahy/view/screens/login/login.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ignore: unused_field
  double _fontSize = 2;
  double _containerSize = 1.5;
  // ignore: unused_field
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController? _controller;
  Animation<double>? animation1;

  StaticDataController sdc = Get.put(StaticDataController());

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller?.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () async {
      StaticDataController sdc = Get.put(StaticDataController());
      await sdc.storageService.isRegistered()
          ? Get.off(
              () => const LoginScreen(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            )
          : Get.off(
              () => const OnboardingLayout(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            );
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // height: height,
                    width: width,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/animation-logo.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 5000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    opacity: _containerOpacity,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      alignment: Alignment.center,
                      width: 40,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScale,

                        /// Required, The loading type of the widget
                        colors: [
                          MyColors.primaryColor,
                          MyColors.secondaryColor,
                        ],

                        /// Optional, The color collections
                        strokeWidth: 2,

                        /// Optional, The stroke of the line, only applicable to widget which contains line
                        // backgroundColor: Colors.black,

                        /// Optional, Background of the widget
                        // pathBackgroundColor: Colors.black,

                        /// Optional, the stroke backgroundColor
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center(
          //   child: AnimatedOpacity(
          //     duration: Duration(milliseconds: 5000),
          //     curve: Curves.fastLinearToSlowEaseIn,
          //     opacity: _containerOpacity,
          //     child: AnimatedContainer(
          //       duration: Duration(milliseconds: 1000),
          //       curve: Curves.fastLinearToSlowEaseIn,
          //       height: _width / _containerSize,
          //       width: _width / _containerSize,
          //       alignment: Alignment.center,
          //       // decoration: BoxDecoration(
          //       //   color: Colors.white,
          //       //   borderRadius: BorderRadius.circular(30),
          //       // ),
          //       // child: Image.asset('assets/images/file_name.png')
          //       child: Image.asset(
          //         'assets/images/app-icon.png',
          //         width: 200,
          //         height: 200,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: AnimatedOpacity(
          //     opacity: _containerOpacity,
          //     duration: const Duration(milliseconds: 5000),
          //     curve: Curves.fastLinearToSlowEaseIn,
          //     child: AnimatedContainer(
          //       duration: const Duration(milliseconds: 2000),
          //       curve: Curves.fastLinearToSlowEaseIn,
          //       // height: _width / _containerSize,
          //       // width: _width / _containerSize,
          //       alignment: Alignment.center,
          //       child: const Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             'By',
          //             style: TextStyle(
          //               color: MyColors.primaryColor,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           // SizedBox(
          //           //   height: 5,
          //           // ),
          //           Text(
          //             'Eng. Hussam Al-Zuraiky',
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 16,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 3000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}
