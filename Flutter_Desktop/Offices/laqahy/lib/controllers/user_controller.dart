import 'dart:convert';
import 'dart:io';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/user_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class UserController extends GetxController {
  StaticDataController sdc = Get.find<StaticDataController>();
  var users = [].obs;
  var filteredUsers = [].obs;
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  PaginatorController tableController = PaginatorController();
  TextEditingController userSearchController = TextEditingController();
  GlobalKey<FormState> createUserAccountFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editUserAccountFormKey = GlobalKey<FormState>();
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
    phoneNumberController.clear();
    passwordController.clear();
    userNameController.clear();
    birthDateController.clear();
    sdc.selectedPermissionId.value = null;
    sdc.selectedGenderId.value = null;
    addressController.clear();
  }

  //////////
  TextEditingController addressController = TextEditingController();
  String? addressValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال العنوان';
    }
    return null;
  }

  @override
  onInit() async {
    centerId = await sdc.storageService.getOfficeId();
    fetchUsers(centerId);
    sdc.fetchGenders();
    sdc.fetchPermissions();
    super.onInit();
  }

  void filterUsers(String keyword) {
    filteredUsers.value = users.where((user) {
      return user.name
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          user.username
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchUsers(var centerId) async {
    try {
      isLoading(true);
      userSearchController.clear();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getUsers}/$centerId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        users.value = jsonData.map((e) => User.fromJson(e)).toList();
        filteredUsers.value = users;
      } else if (response.statusCode == 500) {
        isLoading(false);
        ApiExceptionWidgets().myFetchDataExceptionAlert(response.statusCode);
      } else {
        isLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addUser() async {
    int? centerID = await sdc.storageService.getOfficeId();
    DateTime parsedBirthDate =
        DateFormat('MMM d, yyyy').parse(birthDateController.text);
    try {
      isAddLoading(true);
      final user = User(
        officeId: centerID!,
        name: nameController.text,
        phone: phoneNumberController.text,
        address: addressController.text,
        userGenderId: sdc.selectedGenderId.value!,
        username: userNameController.text,
        password: passwordController.text,
        userPermissionId: sdc.selectedPermissionId.value!,
        birthDate: parsedBirthDate,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addUser),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        isAddLoading(false);
        Get.back();
        ApiExceptionWidgets().myAddedDataSuccessAlert();
        clearTextFields();
        await fetchUsers(centerId);

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

  Future<void> updateUser(
    var userId,
    var name,
    var address,
    var userName,
    var password,
    var permission,
    var phone,
    var gender,
    var birthDate,
  ) async {
    DateTime parsedBirthDate = DateFormat('MMM d, yyyy').parse(birthDate);
    int? centerID = await sdc.storageService.getOfficeId();
    isUpdateLoading(true);
    final user = User(
      officeId: centerID!,
      name: name,
      phone: phone,
      address: address,
      userGenderId: gender!,
      username: userName,
      password: password,
      userPermissionId: permission,
      birthDate: parsedBirthDate,
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.updateUser}/$userId'));
      request.fields['_method'] = 'PATCH';
      request.fields['user_name'] = user.name;
      request.fields['user_phone'] = user.phone;
      request.fields['user_address'] = user.address;
      request.fields['user_birthDate'] =
          DateFormat('yyyy-MM-dd').format(user.birthDate);
      request.fields['user_account_name'] = user.username;
      request.fields['user_account_password'] = user.password;
      request.fields['gender_id'] = user.userGenderId.toString();
      request.fields['healthy_center_id'] = user.officeId.toString();
      request.fields['permission_type_id'] = user.userPermissionId.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        isUpdateLoading(false);
        await fetchUsers(centerId);
        Get.back();
        ApiExceptionWidgets().myUpdateDataSuccessAlert();

        return;
      } else if (response.statusCode == 401) {
        isUpdateLoading(false);
        ApiExceptionWidgets().myUserAlreadyExistsAlert();
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

  Future<void> deleteUser(int userId) async {
    isDeleteLoading(true);
    var adminId = await sdc.storageService.getAdminId();
    if (userId == adminId) {
      isDeleteLoading(false);
      Get.back();
      Constants().playErrorSound();

      return myShowDialog(
        context: Get.context!,
        widgetName: ApiExceptionAlert(
          height: 270,
          imageUrl: 'assets/images/error.json',
          backgroundColor: MyColors.redColor,
          title: 'خطـــأ',
          description: 'عذرا، لا يمكنك حذف مسؤول النظام',
        ),
      );
    }
    try {
      var request =
          await http.delete(Uri.parse('${ApiEndpoints.deleteUser}/$userId'));

      if (request.statusCode == 200) {
        isDeleteLoading(false);
        Get.back();
        ApiExceptionWidgets().myDeleteDataSuccessAlert();
        await fetchUsers(centerId);

        return;
      } else {
        isDeleteLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(request.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isDeleteLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isDeleteLoading(false);
      print(e);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isDeleteLoading(false);
    }
  }
}
