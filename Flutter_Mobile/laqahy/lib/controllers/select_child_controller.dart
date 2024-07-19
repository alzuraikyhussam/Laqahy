import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/child_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/view/widgets/basic_widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:http/http.dart' as http;

class SelectChildController extends GetxController {
  var children = <ChildData>[].obs;
  var selectedChildId = Rx<int?>(null);
  var childErrorMsg = ''.obs;
  var isChildLoading = false.obs;
  TextEditingController childSearchController = TextEditingController();
  StaticDataController sdc = Get.put(StaticDataController());
  GlobalKey<FormState> selectChildFormKey = GlobalKey<FormState>();

  int? motherId;

  @override
  void onInit() {
    super.onInit();
  }

  String? childValidator(value) {
    if (value == null) {
      return 'قم باختيار طفلك';
    }
    return null;
  }

  void fetchChildren() async {
    try {
      motherId = sdc.userLoggedData.first.user.id;
      childErrorMsg('');
      isChildLoading(true);
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getChildData}/$motherId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isChildLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<ChildData> fetchedChildren =
            jsonData.map((e) => ChildData.fromJson(e)).toList();

        children.assignAll(fetchedChildren);

        if (children.isNotEmpty) {
          selectedChildId.value = children.first.id;
        }
      } else {
        isChildLoading(false);
        childErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isChildLoading(false);
      childErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isChildLoading(false);
      childErrorMsg('خطأ غير متوقع\n${e.toString()}');
      print(e);
    } finally {
      isChildLoading(false);
    }
  }

  Widget childrenDropdownMenu() {
    return Obx(() {
      if (isChildLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'اختاري طفلك',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          validator: childValidator,
          selectedValue: null,
        );
      }

      if (childErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: childErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchChildren();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختاري طفلك',
            items: null,
            onChanged: null,
            searchController: null,
            validator: childValidator,
            selectedValue: null,
          ),
        );
      }

      if (children.isEmpty) {
        return InkWell(
          onTap: () {
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لا يوجد لديك أطفال',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchChildren();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختاري طفلك',
            items: null,
            onChanged: null,
            validator: childValidator,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'اختاري طفلك',
        validator: childValidator,
        items: children.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.childName ?? '',
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedChildId.value = int.tryParse(value);
          } else {
            selectedChildId.value = null;
          }
        },
        searchController: childSearchController,
        selectedValue: selectedChildId.value?.toString(),
      );
    });
  }
}
