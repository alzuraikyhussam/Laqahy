import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:uuid/uuid.dart';

class AccountsController extends GetxController {
  @override
  void onInit() {
    fetchRegisteredOfficesInDropDownMenu();
    fetchUnRegisteredOfficesInDropDownMenu();
    fetchOffices();
    fetchCenters();
    super.onInit();
  }

  Uuid createAccountCode = const Uuid();

  PaginatorController officesTableController = PaginatorController();
  TextEditingController officeSearchController = TextEditingController();
  TextEditingController registeredOfficeDropDownMenuSearchController =
      TextEditingController();
  TextEditingController unregisteredOfficeDropDownMenuSearchController =
      TextEditingController();
  var offices = [].obs;
  var filteredOffices = [].obs;
  var isOfficesLoading = true.obs;

  var registeredOfficesDropDownMenu = <Office>[].obs;
  var selectedRegisteredOfficeId = Rx<int?>(null);
  var registeredOfficeErrorMsg = ''.obs;
  var isRegisteredOfficesDropDownMenuLoading = false.obs;

  var unregisteredOfficesDropDownMenu = <Office>[].obs;
  var selectedUnRegisteredOfficeId = Rx<int?>(null);
  var unregisteredOfficeErrorMsg = ''.obs;
  var isUnRegisteredOfficesDropDownMenuLoading = false.obs;

  PaginatorController centersTableController = PaginatorController();
  TextEditingController centersSearchController = TextEditingController();
  var centers = [].obs;
  var filteredCenters = [].obs;
  var isCentersLoading = true.obs;

  var selectedOption = 'all'.obs;

  GlobalKey<FormState> addOfficeAccountFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editOfficeAccountFormKey = GlobalKey<FormState>();
  var isUpdateLoading = false.obs;

  clearTextFields() {
    centersSearchController.clear();
    officeSearchController.clear();
    selectedUnRegisteredOfficeId.value = null;
    addressController.clear();
    phoneNumberController.clear();
    registeredOfficeDropDownMenuSearchController.clear();
    unregisteredOfficeDropDownMenuSearchController.clear();
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

  TextEditingController addressController = TextEditingController();
  String? addressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال العنوان';
    }
    return null;
  }

  /////////////
  String? officeValidator(value) {
    if (value == null) {
      return 'قم باختيار المكتب';
    }
    return null;
  }

  void handleRadioValueChange(value) {
    selectedOption.value = value;
    centers.value = [];
    if (value == 'all') {
      fetchCenters();
    } else if (value == 'centersByOffice') {
      fetchRegisteredOfficesInDropDownMenu();
      if (registeredOfficesDropDownMenu.isNotEmpty &&
          selectedRegisteredOfficeId.value != null) {
        fetchCentersByOffice(selectedRegisteredOfficeId.value!);
      }
    }
  }

  Widget registeredOfficesDropdownMenu() {
    return Obx(() {
      if (isRegisteredOfficesDropDownMenuLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'اختر المكتب',
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
        );
      }

      if (registeredOfficeErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: registeredOfficeErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchRegisteredOfficesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر المكتب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      if (registeredOfficesDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على مكاتب',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchRegisteredOfficesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر المكتب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'اختر المكتب',
        items: registeredOfficesDropDownMenu.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.name ?? '',
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedOption.value = 'centersByOffice';
            selectedRegisteredOfficeId.value = int.tryParse(value);
            fetchCentersByOffice(selectedRegisteredOfficeId.value!);
          } else {
            selectedRegisteredOfficeId.value = null;
          }
        },
        searchController: registeredOfficeDropDownMenuSearchController,
        selectedValue: selectedRegisteredOfficeId.value?.toString(),
      );
    });
  }

  Widget unregisteredOfficesDropdownMenu() {
    return Obx(() {
      if (isUnRegisteredOfficesDropDownMenuLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'اختر المكتب',
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
        );
      }

      if (unregisteredOfficeErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: unregisteredOfficeErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchUnRegisteredOfficesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر المكتب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      if (unregisteredOfficesDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على مكاتب',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchUnRegisteredOfficesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر المكتب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'اختر المكتب',
        items: unregisteredOfficesDropDownMenu.map((element) {
          return DropdownMenuItem(
            value: element.id.toString(),
            child: Text(
              element.name ?? '',
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedUnRegisteredOfficeId.value = int.tryParse(value);
          } else {
            selectedUnRegisteredOfficeId.value = null;
          }
        },
        validator: officeValidator,
        searchController: unregisteredOfficeDropDownMenuSearchController,
        selectedValue: selectedUnRegisteredOfficeId.value?.toString(),
      );
    });
  }

  void fetchRegisteredOfficesInDropDownMenu() async {
    try {
      registeredOfficeErrorMsg('');
      isRegisteredOfficesDropDownMenuLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getRegisteredOffices),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isRegisteredOfficesDropDownMenuLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Office> fetchedOffice =
            jsonData.map((e) => Office.fromJson(e)).toList();
        registeredOfficesDropDownMenu.assignAll(fetchedOffice);
        // if (registeredOfficesDropDownMenu.isNotEmpty) {
        //   selectedRegisteredOfficeId.value =
        //       registeredOfficesDropDownMenu.first.id;
        // }
      } else {
        isRegisteredOfficesDropDownMenuLoading(false);
        registeredOfficeErrorMsg(
            'فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isRegisteredOfficesDropDownMenuLoading(false);
      registeredOfficeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isRegisteredOfficesDropDownMenuLoading(false);
      registeredOfficeErrorMsg('خطأ غير متوقع\n${e.toString()}');
      print(registeredOfficesDropDownMenu);
    } finally {
      isRegisteredOfficesDropDownMenuLoading(false);
    }
  }

  void fetchUnRegisteredOfficesInDropDownMenu() async {
    try {
      unregisteredOfficeErrorMsg('');
      isUnRegisteredOfficesDropDownMenuLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getUnRegisteredOffices),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isUnRegisteredOfficesDropDownMenuLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Office> fetchedOffice =
            jsonData.map((e) => Office.fromJson(e)).toList();
        unregisteredOfficesDropDownMenu.assignAll(fetchedOffice);
        // selectedUnRegisteredOfficeId.value =
        //     unregisteredOfficesDropDownMenu.first.id;
      } else {
        isUnRegisteredOfficesDropDownMenuLoading(false);
        unregisteredOfficeErrorMsg(
            'فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isUnRegisteredOfficesDropDownMenuLoading(false);
      unregisteredOfficeErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isUnRegisteredOfficesDropDownMenuLoading(false);
      unregisteredOfficeErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isUnRegisteredOfficesDropDownMenuLoading(false);
    }
  }

  void filterOffices(String keyword) {
    filteredOffices.value = offices.where((office) {
      return office.name
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  void filterCenters(String keyword) {
    filteredCenters.value = centers.where((center) {
      return center.name
          .toString()
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchOffices() async {
    try {
      isOfficesLoading(true);
      officeSearchController.clear();
      final response = await http.get(
        Uri.parse(ApiEndpoints.getOfficesCentersCount),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isOfficesLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        offices.value = jsonData.map((e) => Office.fromJson(e)).toList();
        filteredOffices.value = offices;
      } else {
        isOfficesLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isOfficesLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isOfficesLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      print(e);
    } finally {
      isOfficesLoading(false);
    }
  }

  Future<void> fetchCenters() async {
    try {
      isCentersLoading(true);
      centersSearchController.clear();
      final response = await http.get(
        Uri.parse(ApiEndpoints.getCenters),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isCentersLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        centers.value = jsonData.map((e) => HealthyCenter.fromJson(e)).toList();
        filteredCenters.value = centers;
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
      print(e);
    } finally {
      isCentersLoading(false);
    }
  }

  Future<void> fetchCentersByOffice(int officeId) async {
    try {
      isCentersLoading(true);
      centersSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getCentersByOffice}/$officeId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isCentersLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        centers.value = jsonData.map((e) => HealthyCenter.fromJson(e)).toList();
        filteredCenters.value = centers;
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
      print(e);
    } finally {
      isCentersLoading(false);
    }
  }

  Future<void> updateOfficeAccount({
    String alertType = 'add',
    var officeId,
    var phone,
    var address,
  }) async {
    isUpdateLoading(true);

    String? code = createAccountCode.v4().substring(0, 8);

    final office = alertType == 'edit'
        ? Office(
            phone: phone,
            address: address,
          )
        : Office(
            phone: phone,
            address: address,
            createAccountCode: code,
          );

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.updateOffice}/$officeId'));
      request.fields['_method'] = 'PATCH';
      request.fields['office_phone'] = office.phone!;
      request.fields['office_address'] = office.address!;
      alertType == 'add'
          ? request.fields['create_account_code'] = office.createAccountCode!
          : request.fields['create_account_code'] = '';

      var response = await request.send();

      if (response.statusCode == 200) {
        await fetchOffices();
        fetchRegisteredOfficesInDropDownMenu();
        fetchUnRegisteredOfficesInDropDownMenu();
        Get.back();
        alertType == 'add'
            ? ApiExceptionWidgets().myAddedDataSuccessAlert()
            : ApiExceptionWidgets().myUpdateDataSuccessAlert();
        isUpdateLoading(false);
        return;
      } else {
        isUpdateLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
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
