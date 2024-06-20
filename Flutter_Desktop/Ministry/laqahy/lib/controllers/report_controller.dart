import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/utils/centers_pdf_generator.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/home_layout_model.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/models/report_card_model.dart';
import 'package:laqahy/models/user_models.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/reports/create_centers_report.dart';
import 'package:laqahy/view/widgets/reports/create_orders_report.dart';
import 'package:laqahy/view/widgets/reports/create_status_report.dart';
import 'package:laqahy/view/widgets/reports/create_vaccine_report.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  @override
  onInit() {
    fetchRegisteredOfficesInDropDownMenu();
    super.onInit();
  }

  StaticDataController sdc = Get.find<StaticDataController>();

  var centers = <HealthyCenter>[].obs;
  var isGenerateCentersReportLoading = false.obs;

  var adminData = <User>[].obs;
  var isFetchAdminDataLoading = false.obs;

  var registeredOfficesDropDownMenu = <Office>[].obs;
  var selectedRegisteredOfficeId = Rx<int?>(null);
  var registeredOfficeErrorMsg = ''.obs;
  var isRegisteredOfficesDropDownMenuLoading = false.obs;
  TextEditingController registeredOfficeDropDownMenuSearchController =
      TextEditingController();

  List<ReportCardItem> reportsCardItems = [
    ReportCardItem(
      imageName: 'assets/icons/status-icon.png',
      title: 'تقرير عن الحالات',
      onPressed: CreateStatusReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/centers-icon.png',
      title: 'تقرير عن المراكز الصحية',
      onPressed: CreateCentersReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن اللقاحات',
      onPressed: CreateVaccineReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/orders-icon.png',
      title: 'تقرير عن الطلبات',
      onPressed: CreateOrdersReportDialog(),
    ),
  ];

  GlobalKey<FormState> createCentersReportFormKey = GlobalKey<FormState>();

  /////////////
  String? registeredOfficesValidator(value) {
    if (value == null) {
      return 'قم باختيار المكتب';
    }
    return null;
  }

  clearTextFields() {
    selectedRegisteredOfficeId.value = null;
  }

  Future<void> fetchAdminData() async {
    try {
      isFetchAdminDataLoading(true);
      var adminId = await sdc.storageService.getAdminId();
      final response = await http.get(
        Uri.parse('${ApiEndpoints.getAdmin}/$adminId'),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isFetchAdminDataLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        adminData.value = jsonData.map((e) => User.fromJson(e)).toList();
      } else {
        isFetchAdminDataLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
      }
    } on SocketException catch (_) {
      isFetchAdminDataLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
    } catch (e) {
      isFetchAdminDataLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
      print(e);
    } finally {
      isFetchAdminDataLoading(false);
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
          validator: registeredOfficesValidator,
        );
      }

      if (registeredOfficeErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

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
            validator: registeredOfficesValidator,
          ),
        );
      }

      if (registeredOfficesDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().errorAudio();

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
            validator: registeredOfficesValidator,
          ),
        );
      }

      return myDropDownMenuButton2(
        hintText: 'اختر المكتب',
        validator: registeredOfficesValidator,
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
            selectedRegisteredOfficeId.value = int.tryParse(value);
          } else {
            selectedRegisteredOfficeId.value = null;
          }
        },
        searchController: registeredOfficeDropDownMenuSearchController,
        selectedValue: selectedRegisteredOfficeId.value?.toString(),
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

  Future<void> fetchCentersReport() async {
    try {
      isGenerateCentersReportLoading(true);
      var response = await http.get(
        Uri.parse(
            '${ApiEndpoints.getCentersReport}/$selectedRegisteredOfficeId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        centers.value = jsonData.map((e) => HealthyCenter.fromJson(e)).toList();
        await fetchAdminData();

        if (adminData.isNotEmpty) {
          await generateCentersReportPdf(Get.context!);
        } else {
          isGenerateCentersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }

        return;
      } else {
        isGenerateCentersReportLoading(false);
        ApiExceptionWidgets()
            .myAccessDatabaseExceptionAlert(response.statusCode);
        return;
      }
    } on SocketException catch (_) {
      isGenerateCentersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateCentersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateCentersReportLoading(false);
    }
  }

  Future<void> generateCentersReportPdf(BuildContext context) async {
    try {
      final pdfGenerator = CentersPdfGenerator(
        centerData: centers,
        managerName: adminData.first.name,
      );
      await pdfGenerator.generatePdf(context);
      isGenerateCentersReportLoading(false);
    } catch (e) {
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
      print(e);
      isGenerateCentersReportLoading(false);
    }
  }
}
