import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/donor_model.dart';
import 'package:laqahy/models/vaccine_quantity_model.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/models/vaccine_statement_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class VaccineController extends GetxController {
  var vaccines = <VaccineQuantity>[].obs;
  var vaccineStatement = <VaccineStatement>[].obs;
  var fetchDataFuture = Future<void>.value().obs;
  var filteredVaccines = [].obs;
  var isLoading = false.obs;
  var isTableLoading = false.obs;
  var isAddLoading = false.obs;
  var isUpdateLoading = false.obs;
  var isDeleteLoading = false.obs;
  var isAddDonorLoading = false.obs;

  var donors = <Donor>[].obs;
  var selectedDonorId = Rx<int?>(null);
  var donorErrorMsg = ''.obs;
  var isDonorLoading = false.obs;
  final TextEditingController donorSearchController = TextEditingController();
  TextEditingController vaccineSearchController = TextEditingController();
  GlobalKey<FormState> editVaccineQtyFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addQtyVaccineFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addDonorFormKey = GlobalKey<FormState>();
  PaginatorController tableController = PaginatorController();

  @override
  onInit() {
    super.onInit();
    fetchDonors();
    fetchVaccines();
    fetchVaccineStatement();
  }

  void clearTextFormFields() {
    qtyController.clear();
    donorController.clear();
    selectedDonorId.value = null;
    vaccineSearchController.clear();
  }

  TextEditingController donorController = TextEditingController();
  String? donorValidator(value) {
    if (value == null) {
      return 'يجب اختيار الجهة المانحة ';
    }
    return null;
  }

  String? addDonorValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال اسم الجهة المانحة ';
    } else if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return 'لا يمكن ادخال ارقام او رموز';
    }
    return null;
  }

  /////////////
  TextEditingController qtyController = TextEditingController();
  String? qtyValidator(value) {
    if (value.trim().isEmpty) {
      return 'يجب ادخال الكمية';
    } else if (!GetUtils.isNumericOnly(value)) {
      return 'يجب ادخال ارقام فقط';
    } else if (int.tryParse(value)! <= 0) {
      return 'يجب ادخال كمية اكبر من الصفر';
    }
    return null;
  }

  void fetchDonors() async {
    try {
      donorErrorMsg('');
      isDonorLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getDonors),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDonorLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Donor> fetchedDonor =
            jsonData.map((e) => Donor.fromJson(e)).toList();
        donors.assignAll(fetchedDonor);
      } else {
        isDonorLoading(false);
        donorErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDonorLoading(false);
      donorErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDonorLoading(false);
      donorErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDonorLoading(false);
    }
  }

  Future<void> addDonor() async {
    try {
      isAddDonorLoading(true);
      final donor = Donor(
        name: donorController.text,
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addDonor),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(donor.toJson()),
      );

      if (response.statusCode == 201) {
        isAddDonorLoading(false);

        var data = json.decode(response.body);
        Donor donor = Donor.fromJson(data['data']);
        selectedDonorId.value = donor.id;

        Get.back();
        fetchDonors();
        ApiException().myAddedDataSuccessAlert();
        return;
      } else if (response.statusCode == 401) {
        isAddDonorLoading(false);
        myShowDialog(
          context: Get.context!,
          widgetName: ApiExceptionAlert(
            height: 270,
            imageUrl: 'assets/images/error.json',
            backgroundColor: MyColors.redColor,
            title: 'الجهة المانحة موجودة بالفعل',
            description: 'عذرا، هذه الجهة المانحة التي أدخلتها موجودة بالفعل',
          ),
        );
        return;
      } else {
        isAddDonorLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isAddDonorLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddDonorLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddDonorLoading(false);
    }
  }

  Widget donorsDropdownMenu() {
    return Obx(() {
      if (isDonorLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'الجهة المانحة',
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
          validator: donorValidator,
        );
      }

      if (donorErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: donorErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchDonors();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'الجهة المانحة',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: donorValidator,
          ),
        );
      }

      if (donors.isEmpty) {
        return InkWell(
          onTap: () {
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchDonors();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'الجهة المانحة',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: donorValidator,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'الجهة المانحة',
        validator: donorValidator,
        items: donors.map((element) {
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
            selectedDonorId.value = int.tryParse(value);
          } else {
            selectedDonorId.value = null;
          }
        },
        searchController: donorSearchController,
        selectedValue: selectedDonorId.value?.toString(),
      );
    });
  }

  void filterVaccines(String keyword) {
    filteredVaccines.value = vaccineStatement.where((vaccine) {
      return vaccine.vaccineType
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          vaccine.donorName
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
  }

  Future<void> fetchVaccines() async {
    fetchDataFuture.value = Future<void>(() async {
      try {
        isLoading(true);
        final response = await http.get(
          Uri.parse(ApiEndpoints.getVaccines),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          vaccines.value =
              jsonData.map((e) => VaccineQuantity.fromJson(e)).toList();
        } else if (response.statusCode == 500) {
          isLoading(false);
          ApiException().myFetchDataExceptionAlert(response.statusCode);
        } else {
          isLoading(false);
          ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } on SocketException catch (_) {
        isLoading(false);
        ApiException().mySocketExceptionAlert();
      } catch (e) {
        isLoading(false);
        ApiException().myUnknownExceptionAlert(error: e.toString());
      } finally {
        isLoading(false);
      }
    });
  }

  Future<void> fetchVaccineStatement() async {
    try {
      isTableLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getVaccineStatement),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isTableLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        vaccineStatement.value =
            jsonData.map((e) => VaccineStatement.fromJson(e)).toList();
        filteredVaccines.assignAll(vaccineStatement);
      } else if (response.statusCode == 500) {
        isTableLoading(false);
        ApiException().myFetchDataExceptionAlert(response.statusCode);
      } else {
        isTableLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isTableLoading(false);
      ApiException().mySocketExceptionAlert();
    } catch (e) {
      isTableLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isTableLoading(false);
    }
  }

  Future<void> addVaccineQty(int id) async {
    try {
      isAddLoading(true);
      final vaccineQty = VaccineStatement(
        vaccineTypeId: id,
        donorId: selectedDonorId.value,
        quantity: int.tryParse(qtyController.text),
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.addVaccineQuantity),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(vaccineQty.toJson()),
      );

      if (response.statusCode == 201) {
        isAddLoading(false);
        Get.back();
        await fetchVaccines();
        await fetchVaccineStatement();
        ApiException().myAddedDataSuccessAlert();
        return;
      } else {
        isAddLoading(false);
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isAddLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isAddLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isAddLoading(false);
    }
  }

  Future<void> updateVaccineStatement(int id, var quantity) async {
    isUpdateLoading(true);
    final statement = VaccineStatement(
      id: id,
      donorId: selectedDonorId.value,
      quantity: int.tryParse(quantity),
    );
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiEndpoints.updateVaccineStatement}/$id'));
      request.fields['_method'] = 'PATCH';
      request.fields['vaccine_type_id'] = statement.vaccineTypeId.toString();
      request.fields['quantity'] = statement.quantity.toString();
      request.fields['donor_id'] = statement.donorId.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        isUpdateLoading(false);
        Get.back();
        await fetchVaccines();
        await fetchVaccineStatement();
        ApiException().myUpdateDataSuccessAlert();
        return;
      } else {
        isUpdateLoading(false);
        print(await response.stream.bytesToString());
        ApiException().myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isUpdateLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isUpdateLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isUpdateLoading(false);
    }
  }

  Future<void> deleteVaccineStatement(int id) async {
    try {
      isDeleteLoading(true);
      var request = await http
          .delete(Uri.parse('${ApiEndpoints.deleteVaccineStatement}/$id'));
      if (request.statusCode == 200) {
        isDeleteLoading(false);
        Get.back();
        await fetchVaccines();
        await fetchVaccineStatement();
        ApiException().myDeleteDataSuccessAlert();
        return;
      } else {
        isDeleteLoading(false);
        print(request.body);
        ApiException().myAccessDatabaseExceptionAlert(request.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isDeleteLoading(false);
      ApiException().mySocketExceptionAlert();
      return;
    } catch (e) {
      isDeleteLoading(false);
      ApiException().myUnknownExceptionAlert(error: e.toString());
      return;
    } finally {
      isDeleteLoading(false);
    }
  }
}
