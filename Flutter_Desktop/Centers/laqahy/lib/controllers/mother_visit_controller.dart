import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/models/model.dart';

class MotherVisitController extends GetxController {
  RxList<MotherVisitData> myMotherVisitFilteredData = <MotherVisitData>[].obs;

  List<MotherVisitData> myMotherVisitDataList = [];
  RxBool sort = true.obs;

  final motherVisitSearchController = TextEditingController();

  @override
  onInit() {
    myMotherVisitDataList = List<MotherVisitData>.from(myMotherVisitData);
    myMotherVisitFilteredData.assignAll(myMotherVisitData);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    dosageLevelSearchController.close();
  }

  String? dosageLevelSelectedValue;

  final Rx<TextEditingController> dosageLevelSearchController =
      TextEditingController().obs;

  final List<String> dosageLevels = [
    'أساسية',
    'تنشيطية',
  ];

  changeDosageLevelSelectedValue(String selectedValue) {
    dosageLevelSelectedValue = selectedValue;
    update();
  }

  List<MotherVisitData> myMotherVisitData = [
    MotherVisitData(
      dosageType: 'الأولى',
      fullUserName: 'شفيع احمد سعيد قائد',
      healthCenter: 'مركز المظفر',
      dosageDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      returnDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    ),
  ];

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        myMotherVisitFilteredData
            .sort((a, b) => a.dosageType!.compareTo(b.dosageType!));
      } else {
        myMotherVisitFilteredData
            .sort((a, b) => b.dosageType!.compareTo(a.dosageType!));
      }
    }
    update();
  }

  void filterMotherVisitData(String value) {
    if (value.isEmpty) {
      myMotherVisitFilteredData.assignAll(myMotherVisitDataList);
    } else {
      myMotherVisitFilteredData.assignAll(myMotherVisitDataList.where((element) =>
          element.dosageType!.toLowerCase().contains(value.toLowerCase())));
    }
  }
}
