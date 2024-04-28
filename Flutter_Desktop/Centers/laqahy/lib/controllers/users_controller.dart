import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/models/model.dart';

class UsersController extends GetxController {
  RxList<UserData> myUserFilteredData = <UserData>[].obs;

  List<UserData> myUserDataList = [];

  List<UserData> myUserData = [
    UserData(
      id: 1,
      name: 'حسام خالد سعيد علي',
      username: 'hussam2002',
      password: 'hussam2002\$77',
      birthDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      gender: 'ذكر',
      phoneNumber: '772957881',
      permission: 'مستخدم',
      address: 'تعز - حي النسيرية',
    ),
  ];

  RxBool sort = true.obs;

  final userSearchController = TextEditingController();

  @override
  onInit() {
    myUserDataList = List<UserData>.from(myUserData);
    myUserFilteredData.assignAll(myUserData);
    super.onInit();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      if (ascending) {
        myUserFilteredData.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        myUserFilteredData.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
    update();
  }

  void filterUserData(String value) {
    if (value.isEmpty) {
      myUserFilteredData.assignAll(myUserDataList);
    } else {
      myUserFilteredData.assignAll(myUserDataList.where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase())));
    }
  }
}
