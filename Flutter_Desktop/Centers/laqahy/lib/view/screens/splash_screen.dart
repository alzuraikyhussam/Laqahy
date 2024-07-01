import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/view/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // قم بتأخير تحميل الصفحة لبعض الوقت (مثلاً 3 ثواني)، ثم انتقل إلى الشاشة الرئيسية
    Timer(
        const Duration(
          seconds: 5,
        ), () {
      // انتقل إلى الشاشة الرئيسية
      Get.off(() => const WelcomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash-screen-bg.png'),
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Image.asset(
          'assets/images/splash-logo.png',
          width: 450,
        ),
      ),
    );
  }
}
