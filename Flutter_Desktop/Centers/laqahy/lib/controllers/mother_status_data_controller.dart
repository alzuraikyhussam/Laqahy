import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/models/mother_status_data_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class MotherStatusDataController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var mothers = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  GlobalKey<FormState> createMotherStatusDataFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> editUserAccountFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  int? centerId;

  String? nameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الاسم الرباعي';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يجب أن يحتوي الاسم على أرقام أو رموز';
    } else if (!RegExp(r'^\S+(\s+\S+){3}$').hasMatch(value)) {
      // Regular expression to match exactly four words separated by spaces
      return 'يجب ادخال اسمك الرباعي';
    }
    return null;
  }

/////////////
  TextEditingController phoneNumberController = TextEditingController();
  String? phoneNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال رقم الهاتف ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (!GetUtils.isLengthEqualTo(value, 9)) {
      return 'يجب ان يتكون من 9 ارقام';
    }
    return null;
  }

/////////////
  TextEditingController identityNumberController = TextEditingController();
  String? identityNumberValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الرقم الوطني ';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    }
    return null;
  }

/////////////
  TextEditingController birthDateController = TextEditingController();
  String? birthDateValidator(value) {
    if (value.isEmpty) {
      return 'ادخل تاريخ الميلاد';
    }
    return null;
  }

  //////////
  TextEditingController userNameController = TextEditingController();
  String? userNameValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال اسم المستخدم';
    } else if (!GetUtils.isUsername(value)) {
      return 'يجب ادخال اسم مستخدم صالح';
    }
    return null;
  }

  //////////
  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(value) {
    if (value.isEmpty) {
      return 'يجب ادخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب ألا تقل عن 8 أحرف';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]+$')
        .hasMatch(value)) {
      // Check for at least one uppercase letter, one lowercase letter, one digit, and one special character
      return 'يجب أن تحتوي على أحرف كبيرة\n وصغيرة وأرقام ورموز';
    }
    return null;
  }
  //////////

  void clearTextFields() {
    nameController.clear();
    identityNumberController.clear();
    phoneNumberController.clear();
    birthDateController.clear();
    sdc.selectedCityId.value = null;
    sdc.selectedDirectorateId.value = null;
    villageController.clear();
  }

  //////////
  TextEditingController villageController = TextEditingController();
  String? villageValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال اسم العزلة';
    }
    return null;
  }

  @override
  onInit() async {
    centerId = await sdc.storageService.getCenterId();
    // fetchUsers(centerId);
    // sdc.fetchCities();
    super.onInit();
  }

  Future<void> addMotherStatusData() async {
    int? centerID = await sdc.storageService.getCenterId();
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);
    try {
      isAddLoading(true);
      final Mother = Mothers(
      mother_name: nameController.text,
      mother_phone: phoneNumberController.text,
      mother_village: villageController.text,
      mother_birthDate: parsedBirthDate,
      mother_identity_num: identityNumberController.text,
      cities_id: sdc.selectedCityId.value!,
      directorate_id: sdc.selectedDirectorateId.value!,
      healthy_center_id: centerID!,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addMotherStatusData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(Mother.toJson()),
      );

      if (response.statusCode == 201) {
        isAddLoading(false);
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
        clearTextFields();
        // await fetchUsers(centerId);

        return;
      } else if (response.statusCode == 401) {
        isAddLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
        return;
      } else {
        print(response.body);
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

}
