import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:uuid/uuid.dart';

class AccountsController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();

  @override
  void onInit() async {
    fetchCenters();
    sdc.fetchDirectorates(sdc.officeData.first.cityId!);
    super.onInit();
  }

  int? officeId;

  Uuid createAccountCode = const Uuid();

  PaginatorController centersTableController = PaginatorController();
  GlobalKey<FormState> addCenterAccountFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editCenterAccountFormKey = GlobalKey<FormState>();
  TextEditingController centersSearchController = TextEditingController();
  var centers = [].obs;
  var filteredCenters = [].obs;
  var isCentersLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;

  clearTextFields() {
    centersSearchController.clear();
    addressController.clear();
    phoneNumberController.clear();
    centerNameController.clear();
    sdc.selectedDirectorateId.value = null;
  }

  TextEditingController phoneNumberController = TextEditingController();
  String? phoneNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthBetween(value, 6, 9)) {
      return 'يجب أن يكون ما بين 6 الى 9 أرقام';
    }
    return null;
  }

  TextEditingController centerNameController = TextEditingController();
  String? centerNameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال اسم المركز';
    }
    return null;
  }

  TextEditingController addressController = TextEditingController();
  String? addressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال العنوان';
    }
    return null;
  }

  //////////
  ///
  final TextEditingController directoratesSearchController =
      TextEditingController();
  String? directorateValidator(value) {
    if (value == null) {
      return 'قم باختيار المديرية';
    }
    return null;
  }

  void filterCenters(String keyword) {
    filteredCenters.value = centers.where((center) {
      return center.name
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Widget directoratesDropdownMenu() {
    return Obx(() {
      if (sdc.isDirectorateLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'المديرية',
          items: [
            DropdownMenuItem<String>(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: directorateValidator,
        );
      } else if (sdc.directorateErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: sdc.directorateErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    sdc.fetchDirectorates(sdc.officeData.first.cityId!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المديرية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: directorateValidator,
          ),
        );
      } else if (sdc.directorates.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذراً، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    sdc.fetchDirectorates(sdc.officeData.first.cityId!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المديرية',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: directorateValidator,
          ),
        );
      } else {
        return myDropDownMenuButton2(
          hintText: 'المديرية',
          validator: directorateValidator,
          items: sdc.directorates.map((element) {
            return DropdownMenuItem(
              value: element.id.toString(),
              child: Text(
                element.name,
                style: MyTextStyles.font16BlackMedium,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              sdc.selectedDirectorateId.value = int.tryParse(value);
            } else {
              sdc.selectedCityId.value = null;
            }
          },
          searchController: directoratesSearchController,
          selectedValue: sdc.selectedDirectorateId.value?.toString(),
        );
      }
    });
  }

  Future<void> fetchCenters() async {
    try {
      isCentersLoading(true);
      centersSearchController.clear();
      officeId = await sdc.storageService.getOfficeId();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getCenters}/$officeId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        centers.value = jsonData.map((e) => HealthyCenter.fromJson(e)).toList();
        filteredCenters.value = centers;
        isCentersLoading(false);
      } else {
        isCentersLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isCentersLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isCentersLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isCentersLoading(false);
    }
  }

  Future<void> addCenterAccount() async {
    String? code = createAccountCode.v4().substring(0, 8);
    try {
      isAddLoading(true);
      final center = HealthyCenter(
        name: centerNameController.text,
        phone: phoneNumberController.text,
        address: addressController.text,
        cityId: sdc.officeData.first.cityId,
        directorateId: sdc.selectedDirectorateId.value,
        createAccountCode: code,
      );
      var response = await http.post(
        Uri.parse('${ApiEndpoints.addCenterAccount}/$officeId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(center.toJson()),
      );

      if (response.statusCode == 201) {
        await fetchCenters();
        Get.back();

        ApiExceptionWidgets().myAddedDataSuccessAlert();
        clearTextFields();
        isAddLoading(false);

        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myCenterAccountAlreadyExistsAlert();
        return;
      } else {
        isAddLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> updateCenterAccount({
    required int id,
    required String centerName,
    required String phone,
    required String address,
  }) async {
    try {
      isUpdateLoading(true);
      final center = HealthyCenter(
        id: id,
        name: centerName,
        phone: phone,
        address: address,
        cityId: sdc.officeData.first.cityId,
        directorateId: sdc.selectedDirectorateId.value,
      );
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.updateCenterAccount}/$officeId'));
      request.fields['_method'] = 'PATCH';
      request.fields['id'] = center.id.toString();
      request.fields['healthy_center_name'] = center.name.toString();
      request.fields['healthy_center_phone'] = center.phone.toString();
      request.fields['healthy_center_address'] = center.address.toString();
      request.fields['cities_id'] = center.cityId.toString();
      request.fields['directorate_id'] = center.directorateId.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        await fetchCenters();
        Get.back();
        ApiExceptionWidgets().myUpdateDataSuccessAlert();
        isUpdateLoading(false);
        return;
      } else if (response.statusCode == 401) {
        isUpdateLoading(false);
        ApiExceptionWidgets().myCenterAccountAlreadyExistsAlert();
        return;
      } else {
        isUpdateLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        print(await response.stream.bytesToString());
        return;
      }
    } on SocketException catch (_) {
      isUpdateLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUpdateLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUpdateLoading(false);
    }
  }
}
