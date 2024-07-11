import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';

class ChildVisitController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var childStatement = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  GlobalKey<FormState> createChildStatementDataFormKey = GlobalKey<FormState>();
  int? centerId;

  @override
  onInit() async {
    centerId = await sdc.storageService.getCenterId();
    sdc.fetchMothers();
    sdc.fetchVisitType();
    super.onInit();
  }
}


