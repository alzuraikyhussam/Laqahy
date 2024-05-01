import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt currentIndex = 0.obs;

  void changeIndex(index) {
    currentIndex.value = index;
  }
}
