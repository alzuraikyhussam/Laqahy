import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/utils/pdf/centers_pdf_generator.dart';
import 'package:laqahy/core/utils/pdf/offices_pdf_generator.dart';
import 'package:laqahy/core/utils/pdf/orders_pdf_generator.dart';
import 'package:laqahy/core/utils/pdf/status_pdf_generator.dart';
import 'package:laqahy/core/utils/pdf/vaccines_pdf_generator.dart';
import 'package:laqahy/core/utils/pdf/vaccines_stock_pdf_generator.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/child_data_model.dart';
import 'package:laqahy/models/donor_model.dart';
import 'package:laqahy/models/mother_data_model.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/models/order_model.dart';
import 'package:laqahy/models/order_state_model.dart';
import 'package:laqahy/models/report_card_model.dart';
import 'package:laqahy/models/status_type_model.dart';
import 'package:laqahy/models/user_models.dart';
import 'package:laqahy/models/vaccine_quantity_model.dart';
import 'package:laqahy/models/vaccine_statement_model.dart';
import 'package:laqahy/services/api/api_endpoints.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/reports/create_centers_report.dart';
import 'package:laqahy/view/widgets/reports/create_ofices_report.dart';
import 'package:laqahy/view/widgets/reports/create_orders_report.dart';
import 'package:laqahy/view/widgets/reports/create_status_report.dart';
import 'package:laqahy/view/widgets/reports/create_vaccinea_stock_report.dart';
import 'package:http/http.dart' as http;
import 'package:laqahy/view/widgets/reports/create_vaccines_report.dart';

class ReportController extends GetxController {
  @override
  onInit() {
    fetchRegisteredOfficesInDropDownMenu();
    fetchDonors();
    fetchVaccinesInDropDownMenu();
    fetchOrderStateInDropDownMenu();
    super.onInit();
  }

  StaticDataController sdc = Get.find<StaticDataController>();

  Constants cons = Constants();

  var centers = <HealthyCenter>[].obs;
  var isGenerateCentersReportLoading = false.obs;

  var adminData = Rx<User?>(null);

  var registeredOfficesDropDownMenu = <Office>[].obs;
  var selectedRegisteredOffice = Rx<Office?>(null);
  var registeredOfficeErrorMsg = ''.obs;
  var isRegisteredOfficesDropDownMenuLoading = false.obs;
  TextEditingController registeredOfficeDropDownMenuSearchController =
      TextEditingController();

  List<ReportCardItem> reportsCardItems = [
    ReportCardItem(
      imageName: 'assets/icons/office.png',
      title: 'تقرير عن المكاتب',
      onPressed: const CreateOfficesReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/centers-icon.png',
      title: 'تقرير عن المراكز الصحية',
      onPressed: const CreateCentersReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/status-icon.png',
      title: 'تقرير عن الحالات',
      onPressed: const CreateStatusReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/vaccine.png',
      title: 'تقرير عن كمية اللقاحات',
      onPressed: const CreateVaccinesReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن حركة المخزون',
      onPressed: const CreateVaccinesStockReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/orders-icon.png',
      title: 'تقرير عن الطلبات',
      onPressed: const CreateOrdersReportDialog(),
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
    selectedRegisteredOffice.value = null;
    firstDateController.clear();
    lastDateController.clear();
    selectedStatusType.value = null;
    selectedCenter.value = null;
    selectedDonor.value = null;
    selectedVaccine.value = null;
    selectedOrderState.value = null;
  }

  Future<User?> fetchAdminDataIfNeeded() async {
    try {
      if (adminData.value == null) {
        var adminId = await sdc.storageService.getAdminId();
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getAdmin}/$adminId'),
          headers: {
            'content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body)['data'];
          adminData.value = User.fromJson(jsonData);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return adminData.value;
  }

  // --------------------- Centers Report -------------------------------------

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
            cons.playErrorSound();

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
            cons.playErrorSound();

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

      return myDropDownMenuButton2<Office>(
        hintText: 'اختر المكتب',
        validator: registeredOfficesValidator,
        items: registeredOfficesDropDownMenu.map((element) {
          return DropdownMenuItem<Office>(
            value: element,
            child: Text(
              element.name ?? '',
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (Office? value) {
          if (value != null) {
            if (value.id == 0) {
              selectedRegisteredOffice.value = value;
              fetchCentersByOffice(selectedRegisteredOffice.value!.id!);
            } else {
              selectedRegisteredOffice.value = value;

              fetchCentersByOffice(selectedRegisteredOffice.value!.id!);
              selectedCenter.value = null;
            }
          } else {
            selectedRegisteredOffice.value = null;
          }
        },
        searchController: registeredOfficeDropDownMenuSearchController,
        selectedValue: selectedRegisteredOffice.value,
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

        fetchedOffice.insert(0, Office(id: 0, name: 'الكل'));

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

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getCentersReport}/${selectedRegisteredOffice.value!.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          centers.value =
              jsonData.map((e) => HealthyCenter.fromJson(e)).toList();
          await generateCentersReportPdf(Get.context!);
          return;
        } else {
          isGenerateCentersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateCentersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
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
        officeName: selectedRegisteredOffice.value!.id == 0
            ? 'جميع مكاتب الصحة والسكان'
            : centers.first.officeName,
        centerData: centers,
        managerName: adminData.value?.name,
      );
      await pdfGenerator.generatePdf(context);
      isGenerateCentersReportLoading(false);
    } catch (e) {
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
      print(e);
      isGenerateCentersReportLoading(false);
    }
  }

// ----------------------------------------------------------

// --------------------- Status Report -------------------------------------

  GlobalKey<FormState> createStatusReportFormKey = GlobalKey<FormState>();
  var isCentersLoading = false.obs;
  var centersErrorMsg = ''.obs;
  var centersDropDownMenu = <HealthyCenter>[].obs;
  var selectedCenter = Rx<HealthyCenter?>(null);

  TextEditingController centersDropDownMenuSearchController =
      TextEditingController();

  var firstDate = Rx<DateTime?>(null);
  var lastDate = Rx<DateTime?>(null);
  var isDatesLoading = true.obs;
  var datesErrorMsg = ''.obs;

  var isGenerateStatusReportLoading = false.obs;
  var mothersData = <MotherData>[].obs;
  var childrenData = <ChildData>[].obs;

  var selectedStatusType = Rx<StatusType?>(null);

  final TextEditingController statusTypeSearchController =
      TextEditingController();

  //////////
  TextEditingController firstDateController = TextEditingController();
  String? firstDateValidator(value) {
    if (value.isEmpty) {
      return 'اختر تاريخ البداية';
    }
    return null;
  }

  //////////
  TextEditingController lastDateController = TextEditingController();
  String? lastDateValidator(value) {
    if (value.isEmpty) {
      return 'اختر تاريخ النهاية';
    }
    return null;
  }

  /////////////

  String? centersValidator(value) {
    if (value == null) {
      return 'قم باختيار المركز الصحي';
    }
    return null;
  }

  /////////////

  String? statusTypeValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع الحالة';
    }
    return null;
  }

  final List<StatusType> statusTypes = [
    StatusType(
      id: 1,
      type: 'الأمهات',
    ),
    StatusType(
      id: 2,
      type: 'الأطفال',
    ),
  ].obs;

  Widget statusTypeDropdownMenu() {
    final ReportController rc = Get.put(ReportController());

    return Obx(() {
      return myDropDownMenuButton2<StatusType>(
        hintText: 'نوع الحالة',
        validator: statusTypeValidator,
        items: statusTypes.map((element) {
          return DropdownMenuItem<StatusType>(
            value: element,
            child: Text(
              element.type,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (StatusType? value) {
          if (value != null) {
            rc.selectedStatusType.value = value;
          } else {
            rc.selectedStatusType.value = null;
          }
        },
        searchController: statusTypeSearchController,
        selectedValue: rc.selectedStatusType.value,
      );
    });
  }

  dateField({
    required String hintText,
    required TextEditingController? controller,
    required String? Function(String?)? validator,
    required void Function()? onPressedRefresh,
  }) {
    return Obx(() {
      if (isDatesLoading.value) {
        return myTextField(
          width: 160,
          controller: null,
          validator: validator,
          prefixIcon: Icons.date_range_outlined,
          readOnly: true,
          hintText: hintText,
          keyboardType: TextInputType.datetime,
          onChanged: (value) {},
          onTap: () {},
        );
      }

      if (datesErrorMsg.isNotEmpty) {
        return myTextField(
          width: 160,
          controller: null,
          validator: validator,
          prefixIcon: Icons.date_range_outlined,
          readOnly: true,
          hintText: hintText,
          keyboardType: TextInputType.datetime,
          onChanged: (value) {},
          onTap: () {
            cons.playErrorSound();
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: datesErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: onPressedRefresh,
                ));
          },
        );
      }

      if (firstDate.value == null || lastDate.value == null) {
        return myTextField(
          width: 160,
          controller: null,
          validator: validator,
          prefixIcon: Icons.date_range_outlined,
          readOnly: true,
          hintText: hintText,
          keyboardType: TextInputType.datetime,
          onChanged: (value) {},
          onTap: () {
            cons.playErrorSound();
            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: onPressedRefresh,
                ));
          },
        );
      }

      return myTextField(
        width: 160,
        controller: controller,
        validator: validator,
        prefixIcon: Icons.date_range_outlined,
        readOnly: true,
        hintText: hintText,
        keyboardType: TextInputType.datetime,
        onChanged: (value) {},
        onTap: () {
          // showDateRangePicker(
          //         context: context,
          //         firstDate: DateTime(2024),
          //         lastDate: DateTime.now())
          //     .then((value) {
          //   if (value == null) {
          //     return;
          //   } else {
          //     rc.beginDateController.text = value.toString();
          //   }
          // });

          showDatePicker(
            context: Get.context!,
            firstDate: firstDate.value!,
            lastDate: lastDate.value!,
            initialDate: firstDate.value,
          ).then(
            (value) {
              if (value == null) {
                return;
              } else {
                controller?.text = DateFormat('dd-MM-yyyy').format(value);
              }
            },
          );
        },
      );
    });
  }

  Future<void> fetchMinMaxStatusDates() async {
    try {
      datesErrorMsg('');
      isDatesLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getMotherDateRange),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDatesLoading(false);
        var data = json.decode(response.body);
        firstDate.value = DateTime.parse(data['min_date']);
        lastDate.value = DateTime.parse(data['max_date']);
        print(data);
      } else {
        isDatesLoading(false);
        datesErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDatesLoading(false);
      datesErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDatesLoading(false);
      datesErrorMsg('خطأ غير متوقع\n${e.toString()}');
      print(e);
    } finally {
      isDatesLoading(false);
    }
  }

  Widget centersDropdownMenu() {
    return Obx(() {
      if (selectedRegisteredOffice.value == null) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
              context: Get.context!,
              widgetName: ApiExceptionAlert(
                title: 'تنبيــه',
                description: 'من فضلك، قم باختيار المكتب أولاً',
                height: 280,
              ),
            );
          },
          child: myDropDownMenuButton2(
            hintText: 'المركز الصحي',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: centersValidator,
          ),
        );
      } else if (isCentersLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'المركز الصحي',
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
          validator: centersValidator,
        );
      } else if (centersErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: centersErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchCentersByOffice(selectedRegisteredOffice.value!.id!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المركز الصحي',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: centersValidator,
          ),
        );
      } else if (centersDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على مراكز في هذا المكتب',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchCentersByOffice(selectedRegisteredOffice.value!.id!);
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'المركز الصحي',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: centersValidator,
          ),
        );
      } else {
        return myDropDownMenuButton2<HealthyCenter>(
          hintText: 'المركز الصحي',
          validator: centersValidator,
          items: centersDropDownMenu.map((element) {
            return DropdownMenuItem<HealthyCenter>(
              value: element,
              child: Text(
                element.name ?? '',
                style: MyTextStyles.font16BlackMedium,
              ),
            );
          }).toList(),
          onChanged: (HealthyCenter? value) {
            if (value != null) {
              if (value.id == 0) {
                selectedCenter.value = value;
              } else {
                selectedCenter.value = value;
                // print(  centersDropDownMenu.firstWhere((element) => element.id == selectedCenterId.value));
              }
            } else {
              selectedCenter.value = null;
            }
          },
          searchController: centersDropDownMenuSearchController,
          selectedValue: selectedCenter.value,
        );
      }
    });
  }

  Future<void> fetchCentersByOffice(int officeId) async {
    centersErrorMsg('');
    if (officeId == 0) {
      centersDropDownMenu.clear();
      centersDropDownMenu.assign(HealthyCenter(id: 0, name: 'الكل'));
      selectedCenter.value = centersDropDownMenu.first;
    } else {
      try {
        isCentersLoading(true);
        final response = await http.get(
          Uri.parse('${ApiEndpoints.getCentersByOffice}/$officeId'),
          headers: {
            'content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          isCentersLoading(false);
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<HealthyCenter> fetchedCenter =
              jsonData.map((e) => HealthyCenter.fromJson(e)).toList();

          fetchedCenter.insert(0, HealthyCenter(id: 0, name: 'الكل'));
          centersDropDownMenu.assignAll(fetchedCenter);
        } else {
          isCentersLoading(false);
          centersErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
        }
      } on SocketException catch (_) {
        isCentersLoading(false);
        centersErrorMsg(
            'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
      } catch (e) {
        isCentersLoading(false);
        centersErrorMsg('خطأ غير متوقع\n${e.toString()}');
      } finally {
        isCentersLoading(false);
      }
    }
  }

  void handleStatusReportOptions() {
    if (selectedRegisteredOffice.value!.id == 0 &&
        selectedCenter.value!.id == 0) {
      fetchStatusInAllOfficesReport();
    } else if (selectedCenter.value!.id == 0) {
      fetchStatusInAllCenters();
    } else {
      fetchStatusReport();
    }
  }

  Future<void> fetchStatusReport() async {
    try {
      isGenerateStatusReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getStatusReport}?status_type=${selectedStatusType.value!.id}&center_id=${selectedCenter.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          if (selectedStatusType.value!.id == 1) {
            mothersData.value =
                jsonData.map((e) => MotherData.fromJson(e)).toList();
          } else if (selectedStatusType.value!.id == 2) {
            childrenData.value =
                jsonData.map((e) => ChildData.fromJson(e)).toList();
          }

          await generateStatusReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع حالات ${selectedStatusType.value!.type} في ${selectedRegisteredOffice.value?.name} - مركز ${selectedCenter.value!.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateStatusReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateCentersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateStatusReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateStatusReportLoading(false);
      print(e);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateStatusReportLoading(false);
    }
  }

  Future<void> fetchStatusInAllOfficesReport() async {
    try {
      isGenerateStatusReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getStatusInAllOfficesReport}?status_type=${selectedStatusType.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          if (selectedStatusType.value!.id == 1) {
            mothersData.value =
                jsonData.map((e) => MotherData.fromJson(e)).toList();
          } else if (selectedStatusType.value!.id == 2) {
            childrenData.value =
                jsonData.map((e) => ChildData.fromJson(e)).toList();
          }

          await generateStatusReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع حالات ${selectedStatusType.value!.type} في جميع مكاتب الصحة والسكان من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateStatusReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateStatusReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateStatusReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateStatusReportLoading(false);
      print(e);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateStatusReportLoading(false);
    }
  }

  Future<void> fetchStatusInAllCenters() async {
    try {
      isGenerateStatusReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getStatusInAllCentersReport}?status_type=${selectedStatusType.value!.id}&office_id=${selectedRegisteredOffice.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          if (selectedStatusType.value!.id == 1) {
            mothersData.value =
                jsonData.map((e) => MotherData.fromJson(e)).toList();
          } else if (selectedStatusType.value!.id == 2) {
            childrenData.value =
                jsonData.map((e) => ChildData.fromJson(e)).toList();
          }

          await generateStatusReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع حالات ${selectedStatusType.value!.type} في جميع المراكز المتواجدة في ${selectedRegisteredOffice.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateStatusReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateStatusReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateStatusReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateStatusReportLoading(false);
      print(e);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateStatusReportLoading(false);
    }
  }

  Future<void> generateStatusReportPdf({
    required BuildContext context,
    required String reportName,
  }) async {
    try {
      late StatusPdfGenerator pdfGenerator;
      if (selectedStatusType.value!.id == 1) {
        pdfGenerator = StatusPdfGenerator(
          reportName: reportName,
          data: mothersData
              .map(
                (data) => [
                  DateFormat('dd-MM-yyyy HH:mm').format(data.createdAt!),
                  data.village,
                  data.directorateName,
                  data.cityName,
                  DateFormat('dd-MM-yyyy').format(data.birthDate!),
                  data.phone,
                  data.healthyCenterName,
                  data.identityNum,
                  data.childrenCount,
                  data.name,
                  data.id,
                ],
              )
              .toList(),
          managerName: adminData.value?.name,
          tableHeader: [
            'تاريخ التسجيل',
            'العزلة',
            'المديرية',
            'المحافظة',
            'تاريخ الميلاد',
            'رقم الجوال',
            'اسم المركز',
            'رقم الهوية',
            'عدد الأطفال',
            'الاسم',
            'م',
          ],
        );
        await pdfGenerator.generatePdf(context);
      } else if (selectedStatusType.value!.id == 2) {
        pdfGenerator = StatusPdfGenerator(
          reportName: reportName,
          data: childrenData
              .map(
                (data) => [
                  DateFormat('dd-MM-yyyy HH:mm').format(data.createdAt!),
                  data.birthplace,
                  DateFormat('dd-MM-yyyy').format(data.birthDate!),
                  data.gender,
                  data.healthyCenterName,
                  data.officeName,
                  data.motherName,
                  data.name,
                  data.id,
                ],
              )
              .toList(),
          managerName: adminData.value?.name,
          tableHeader: [
            'تاريخ التسجيل',
            'مكان الميلاد',
            'تاريخ الميلاد',
            'الجنس',
            'اسم المركز',
            'اسم المكتب',
            'اسم الأم',
            'اسم الطفل',
            'م',
          ],
        );
        await pdfGenerator.generatePdf(context);
      }

      isGenerateStatusReportLoading(false);
    } catch (e) {
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
      print(e);
      isGenerateStatusReportLoading(false);
    }
  }

// ----------------------------------------------------------

// --------------------- Offices Report -------------------------------------

  var offices = <Office>[].obs;

  Future<void> fetchOfficesReport() async {
    try {
// جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(ApiEndpoints.getOfficesReport),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<Office> fetchedOffice =
              jsonData.map((office) => Office.fromJson(office)).toList();
          offices.assignAll(fetchedOffice);

          await generateOfficesReportPdf(context: Get.context!);
        } else {
          Get.back();
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } else {
        Get.back();
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      Get.back();
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {}
  }

  Future<void> generateOfficesReportPdf({
    required BuildContext context,
  }) async {
    try {
      final pdfGenerator = OfficesPdfGenerator(
        reportName:
            'تقرير عن جميع مكاتب الصحة والسكان في محافظات الجمهورية اليمنية',
        data: offices,
        managerName: adminData.value?.name,
      );
      await pdfGenerator.generatePdf(context);
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
    }
  }

// ----------------------------------------------------------

// --------------------- Vaccines Quantity Report -------------------------------------

  var vaccinesQty = <Vaccine>[].obs;

  Future<void> fetchVaccinesQtyReport() async {
    try {
      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(ApiEndpoints.getVaccinesQtyReport),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;
          List<Vaccine> fetchedVaccine =
              jsonData.map((vaccine) => Vaccine.fromJson(vaccine)).toList();
          vaccinesQty.assignAll(fetchedVaccine);
          print(jsonData);

          await generateVaccinesReportPdf(context: Get.context!);
        } else {
          Get.back();
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
        }
      } else {
        Get.back();
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      Get.back();
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {}
  }

  Future<void> generateVaccinesReportPdf({
    required BuildContext context,
  }) async {
    try {
      final pdfGenerator = VaccinesPdfGenerator(
        reportName: 'تقرير عن الكمية المتبقية من اللقاحات',
        data: vaccinesQty,
        managerName: adminData.value?.name,
      );
      await pdfGenerator.generatePdf(context);
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
    }
  }

// ----------------------------------------------------------

// --------------------- Vaccines Stock Report -------------------------------------

  GlobalKey<FormState> createVaccinesStockReportFormKey =
      GlobalKey<FormState>();

  var vaccinesDropDownMenu = <Vaccine>[].obs;
  var selectedVaccine = Rx<Vaccine?>(null);
  var vaccinesErrorMsg = ''.obs;
  var isVaccinesDropDownMenuLoading = false.obs;

  var donorsDropDownMenu = <Donor>[].obs;
  var selectedDonor = Rx<Donor?>(null);
  var donorErrorMsg = ''.obs;
  var isDonorLoading = false.obs;

  var isGenerateVaccinesStockReportLoading = false.obs;
  var vaccinesStock = <VaccineStatement>[].obs;

  TextEditingController vaccinesDropDownMenuSearchController =
      TextEditingController();
  TextEditingController donorsDropDownMenuSearchController =
      TextEditingController();

  String? vaccinesValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع اللقاح';
    }
    return null;
  }

  //////////
  String? donorValidator(value) {
    if (value == null) {
      return 'قم باختيار الجهة المانحة';
    }
    return null;
  }

  Future<void> fetchMinMaxVaccinesStockDates() async {
    try {
      datesErrorMsg('');
      isDatesLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getVaccineStockDateRange),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDatesLoading(false);
        var data = json.decode(response.body);
        firstDate.value = DateTime.parse(data['min_date']);
        lastDate.value = DateTime.parse(data['max_date']);
      } else {
        isDatesLoading(false);
        print(response.body);
        datesErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDatesLoading(false);
      datesErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDatesLoading(false);
      datesErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDatesLoading(false);
    }
  }

  Widget vaccinesDropdownMenu() {
    return Obx(() {
      if (isVaccinesDropDownMenuLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'اختر اللقاح',
          items: [
            DropdownMenuItem(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: vaccinesValidator,
        );
      }

      if (vaccinesErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: vaccinesErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchVaccinesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر اللقاح',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: vaccinesValidator,
          ),
        );
      }

      if (vaccinesDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على لقاحات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchVaccinesInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'اختر اللقاح',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: vaccinesValidator,
          ),
        );
      }

      return myDropDownMenuButton2<Vaccine>(
        hintText: 'اختر اللقاح',
        validator: vaccinesValidator,
        items: vaccinesDropDownMenu.map((element) {
          return DropdownMenuItem<Vaccine>(
            value: element,
            child: Text(
              element.vaccineType ?? '',
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (Vaccine? value) {
          if (value != null) {
            if (value.id == 0) {
              selectedVaccine.value = value;
            } else {
              selectedVaccine.value = value;
            }
          } else {
            selectedVaccine.value = null;
          }
        },
        searchController: vaccinesDropDownMenuSearchController,
        selectedValue: selectedVaccine.value,
      );
    });
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
            Constants().playErrorSound();

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

      if (donorsDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            Constants().playErrorSound();

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

      return myDropDownMenuButton2<Donor>(
        hintText: 'الجهة المانحة',
        validator: donorValidator,
        items: donorsDropDownMenu.map((element) {
          return DropdownMenuItem<Donor>(
            value: element,
            child: Text(
              element.name,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (Donor? value) {
          if (value != null) {
            selectedDonor.value = value;
          } else {
            selectedDonor.value = null;
          }
        },
        searchController: donorsDropDownMenuSearchController,
        selectedValue: selectedDonor.value,
      );
    });
  }

  void fetchVaccinesInDropDownMenu() async {
    try {
      vaccinesErrorMsg('');
      isVaccinesDropDownMenuLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getVaccines),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isVaccinesDropDownMenuLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<Vaccine> fetchedVaccines =
            jsonData.map((e) => Vaccine.fromJson(e)).toList();

        fetchedVaccines.insert(0, Vaccine(id: 0, vaccineType: 'الكل'));

        vaccinesDropDownMenu.assignAll(fetchedVaccines);
      } else {
        isVaccinesDropDownMenuLoading(false);
        vaccinesErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isVaccinesDropDownMenuLoading(false);
      vaccinesErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isVaccinesDropDownMenuLoading(false);
      vaccinesErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isVaccinesDropDownMenuLoading(false);
    }
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
        donorsDropDownMenu.assignAll(fetchedDonor);

        fetchedDonor.insert(0, Donor(id: 0, name: 'الكل'));

        donorsDropDownMenu.assignAll(fetchedDonor);
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

  void handleVaccinesStockReportOptions() {
    if (selectedVaccine.value!.id == 0 && selectedDonor.value!.id == 0) {
      fetchAllVaccinesStockReport();
    } else if (selectedVaccine.value!.id == 0) {
      fetchAllVaccinesStockOfSpecificDonorReport();
    } else if (selectedDonor.value!.id == 0) {
      fetchSpecificVaccineStockOfAllDonorsReport();
    } else {
      fetchVaccinesStockCustomReport();
    }
  }

  Future<void> fetchAllVaccinesStockReport() async {
    try {
      isGenerateVaccinesStockReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllVaccinesStockReport}?first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          vaccinesStock.value =
              jsonData.map((e) => VaccineStatement.fromJson(e)).toList();

          await generateVaccinesStockReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن حركة مخزون جميع اللقاحات الواردة من جميع الجهات المانحة من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateVaccinesStockReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateVaccinesStockReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateVaccinesStockReportLoading(false);
    }
  }

  Future<void> fetchVaccinesStockCustomReport() async {
    try {
      isGenerateVaccinesStockReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getVaccinesStockCustomReport}?vaccine_type=${selectedVaccine.value!.vaccineTypeId}&donor=${selectedDonor.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          vaccinesStock.value =
              jsonData.map((e) => VaccineStatement.fromJson(e)).toList();

          await generateVaccinesStockReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن حركة مخزون لقاح ${selectedVaccine.value?.vaccineType} الواردة من جهة ${selectedDonor.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateVaccinesStockReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateVaccinesStockReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateVaccinesStockReportLoading(false);
    }
  }

  Future<void> fetchAllVaccinesStockOfSpecificDonorReport() async {
    try {
      isGenerateVaccinesStockReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllVaccinesStockOfSpecificDonorReport}?donor=${selectedDonor.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          vaccinesStock.value =
              jsonData.map((e) => VaccineStatement.fromJson(e)).toList();

          await generateVaccinesStockReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن حركة مخزون جميع اللقاحات الواردة من جهة ${selectedDonor.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateVaccinesStockReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateVaccinesStockReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateVaccinesStockReportLoading(false);
    }
  }

  Future<void> fetchSpecificVaccineStockOfAllDonorsReport() async {
    try {
      isGenerateVaccinesStockReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getSpecificVaccineStockOfAllDonorsReport}?vaccine_type=${selectedVaccine.value!.vaccineTypeId}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          vaccinesStock.value =
              jsonData.map((e) => VaccineStatement.fromJson(e)).toList();

          await generateVaccinesStockReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن حركة مخزون لقاح ${selectedVaccine.value?.vaccineType} الواردة من جميع الجهات المانحة من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateVaccinesStockReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateVaccinesStockReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateVaccinesStockReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateVaccinesStockReportLoading(false);
    }
  }

  Future<void> generateVaccinesStockReportPdf({
    required BuildContext context,
    required String reportName,
  }) async {
    try {
      final VaccinesStockPdfGenerator pdfGenerator = VaccinesStockPdfGenerator(
        reportName: reportName,
        data: vaccinesStock,
        managerName: adminData.value?.name,
      );
      await pdfGenerator.generatePdf(context);

      isGenerateVaccinesStockReportLoading(false);
    } catch (e) {
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
      isGenerateVaccinesStockReportLoading(false);
    }
  }

// ----------------------------------------------------------

// --------------------- Orders Report -------------------------------------

  GlobalKey<FormState> createOrdersReportFormKey = GlobalKey<FormState>();

  var orderStateDropDownMenu = <OrderState>[].obs;
  var selectedOrderState = Rx<OrderState?>(null);
  var orderStateErrorMsg = ''.obs;
  var isGenerateOrdersReportLoading = false.obs;
  var isOrderStateDropDownMenuLoading = false.obs;
  var orders = <Order>[].obs;
  final TextEditingController orderStateDropDownMenuSearchController =
      TextEditingController();

  //////////
  String? orderStateValidator(value) {
    if (value == null) {
      return 'قم باختيار حالة الطلب';
    }
    return null;
  }

  Future<void> fetchMinMaxOrdersDates() async {
    try {
      datesErrorMsg('');
      isDatesLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getOrdersDateRange),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isDatesLoading(false);
        var data = json.decode(response.body);
        firstDate.value = DateTime.parse(data['min_date']);
        lastDate.value = DateTime.parse(data['max_date']);
      } else {
        isDatesLoading(false);
        datesErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isDatesLoading(false);
      datesErrorMsg('لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isDatesLoading(false);
      datesErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isDatesLoading(false);
    }
  }

  Widget orderStateDropdownMenu() {
    return Obx(() {
      if (isOrderStateDropDownMenuLoading.value) {
        return myDropDownMenuButton2(
          hintText: 'حالة الطلب',
          items: [
            DropdownMenuItem(
              child: Center(
                child: myLoadingIndicator(),
              ),
            ),
          ],
          onChanged: null,
          searchController: null,
          selectedValue: null,
          validator: orderStateValidator,
        );
      }

      if (orderStateErrorMsg.isNotEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'حدث خطأ ما',
                  description: orderStateErrorMsg.value,
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchOrderStateInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'حالة الطلب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: orderStateValidator,
          ),
        );
      }

      if (orderStateDropDownMenu.isEmpty) {
        return InkWell(
          onTap: () {
            cons.playErrorSound();

            myShowDialog(
                context: Get.context!,
                widgetName: ApiExceptionAlert(
                  title: 'لا تـــوجد بيـــانات',
                  description: 'عذرا، لم يتم العثور على بيانات',
                  height: 280,
                  btnLabel: 'تحــديث',
                  onPressed: () {
                    fetchOrderStateInDropDownMenu();
                    Get.back();
                  },
                ));
          },
          child: myDropDownMenuButton2(
            hintText: 'حالة الطلب',
            items: null,
            onChanged: null,
            searchController: null,
            selectedValue: null,
            validator: orderStateValidator,
          ),
        );
      }

      return myDropDownMenuButton2<OrderState>(
        hintText: 'حالة الطلب',
        validator: orderStateValidator,
        items: orderStateDropDownMenu.map((element) {
          return DropdownMenuItem<OrderState>(
            value: element,
            child: Text(
              element.state,
              style: MyTextStyles.font16BlackMedium,
            ),
          );
        }).toList(),
        onChanged: (OrderState? value) {
          if (value != null) {
            if (value.id == 0) {
              selectedOrderState.value = value;
            } else {
              selectedOrderState.value = value;
            }
          } else {
            selectedOrderState.value = null;
          }
        },
        searchController: orderStateDropDownMenuSearchController,
        selectedValue: selectedOrderState.value,
      );
    });
  }

  void fetchOrderStateInDropDownMenu() async {
    try {
      orderStateErrorMsg('');
      isOrderStateDropDownMenuLoading(true);
      final response = await http.get(
        Uri.parse(ApiEndpoints.getOrderStates),
        headers: {
          'content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        isOrderStateDropDownMenuLoading(false);
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        List<OrderState> fetchedOrderState =
            jsonData.map((e) => OrderState.fromJson(e)).toList();

        fetchedOrderState.insert(0, OrderState(id: 0, state: 'الكل'));

        orderStateDropDownMenu.assignAll(fetchedOrderState);
      } else {
        isOrderStateDropDownMenuLoading(false);
        orderStateErrorMsg('فشل في تحميل البيانات\n${response.statusCode}');
      }
    } on SocketException catch (_) {
      isOrderStateDropDownMenuLoading(false);
      orderStateErrorMsg(
          'لا يتوفر اتصال بالإنترنت، يجب التحقق من اتصالك بالإنترنت');
    } catch (e) {
      isOrderStateDropDownMenuLoading(false);
      orderStateErrorMsg('خطأ غير متوقع\n${e.toString()}');
    } finally {
      isOrderStateDropDownMenuLoading(false);
    }
  }

  void handleOrdersReportOptions() {
    if (selectedRegisteredOffice.value!.id == 0 &&
        selectedVaccine.value!.id == 0 &&
        selectedOrderState.value!.id == 0) {
      fetchAllOrdersReport();
    } else if (selectedRegisteredOffice.value!.id == 0 &&
        selectedVaccine.value!.id == 0) {
      fetchAllVaccinesOfAllOfficesOrdersReport();
    } else if (selectedRegisteredOffice.value!.id == 0 &&
        selectedOrderState.value!.id == 0) {
      fetchAllStatesOfAllOfficesOrdersReport();
    } else if (selectedVaccine.value!.id == 0 &&
        selectedOrderState.value!.id == 0) {
      fetchAllStatesOfAllVaccinesOrdersReport();
    } else if (selectedRegisteredOffice.value!.id == 0) {
      fetchAllOfficesOrdersReport();
    } else if (selectedVaccine.value!.id == 0) {
      fetchAllVaccinesOrdersReport();
    } else if (selectedOrderState.value!.id == 0) {
      fetchAllStatesOrdersReport();
    } else {
      fetchCustomOrdersReport();
    }
  }

  Future<void> fetchAllOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllOrdersReport}?first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع طلبات مكاتب الصحة والسكان من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllVaccinesOfAllOfficesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllVaccinesOfAllOfficesOrdersReport}?order_state=${selectedOrderState.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع الطلبات (${selectedOrderState.value?.state}) الواردة من جميع مكاتب الصحة والسكان من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllStatesOfAllOfficesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllStatesOfAllOfficesOrdersReport}?vaccine_type=${selectedVaccine.value!.vaccineTypeId}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع طلبات لقاح (${selectedVaccine.value?.vaccineType}) الواردة من جميع مكاتب الصحة والسكان من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllStatesOfAllVaccinesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllStatesOfAllVaccinesOrdersReport}?office=${selectedRegisteredOffice.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن طلبات جميع اللقاحات الواردة من ${selectedRegisteredOffice.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllOfficesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllOfficesOrdersReport}?vaccine_type=${selectedVaccine.value!.vaccineTypeId}&order_state=${selectedOrderState.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع الطلبات (${selectedOrderState.value?.state}) الخاصة بلقاح (${selectedVaccine.value?.vaccineType}) من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllVaccinesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllVaccinesOrdersReport}?office=${selectedRegisteredOffice.value!.id}&order_state=${selectedOrderState.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع الطلبات (${selectedOrderState.value?.state}) لجميع اللقاحات الواردة من ${selectedRegisteredOffice.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchAllStatesOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getAllStatesOrdersReport}?office=${selectedRegisteredOffice.value!.id}&vaccine_type=${selectedVaccine.value!.vaccineTypeId}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع الطلبات الواردة من ${selectedRegisteredOffice.value?.name} الخاصة بلقاح (${selectedVaccine.value?.vaccineType}) من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> fetchCustomOrdersReport() async {
    try {
      isGenerateOrdersReportLoading(true);

      // جلب بيانات الإدمن إذا لم تكن متاحة بالفعل
      await fetchAdminDataIfNeeded();

      if (adminData.value != null) {
        var response = await http.get(
          Uri.parse(
              '${ApiEndpoints.getCustomOrdersReport}?office=${selectedRegisteredOffice.value!.id}&vaccine_type=${selectedVaccine.value!.vaccineTypeId}&order_state=${selectedOrderState.value!.id}&first_date=${firstDateController.text}&last_date=${lastDateController.text}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.body)['data'] as List;

          orders.value = jsonData.map((e) => Order.fromJson(e)).toList();

          await generateOrdersReportPdf(
            context: Get.context!,
            reportName:
                'تقرير عن جميع الطلبات (${selectedOrderState.value?.state}) الخاصة بلقاح (${selectedVaccine.value?.vaccineType}) الواردة من ${selectedRegisteredOffice.value?.name} من تاريخ ${firstDateController.text} الى تاريخ ${lastDateController.text}',
          );
        } else {
          isGenerateOrdersReportLoading(false);
          ApiExceptionWidgets()
              .myAccessDatabaseExceptionAlert(response.statusCode);
          return;
        }
      } else {
        isGenerateOrdersReportLoading(false);
        ApiExceptionWidgets().myUnknownExceptionAlert();
      }
    } on SocketException catch (_) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().mySocketExceptionAlert();
      return;
    } catch (e) {
      isGenerateOrdersReportLoading(false);
      ApiExceptionWidgets().myUnknownExceptionAlert(error: e.toString());
    } finally {
      isGenerateOrdersReportLoading(false);
    }
  }

  Future<void> generateOrdersReportPdf({
    required BuildContext context,
    required String reportName,
  }) async {
    try {
      final OrdersPdfGenerator pdfGenerator = OrdersPdfGenerator(
        reportName: reportName,
        data: orders,
        managerName: adminData.value?.name,
      );
      await pdfGenerator.generatePdf(context);

      isGenerateOrdersReportLoading(false);
    } catch (e) {
      print(e);
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
      isGenerateOrdersReportLoading(false);
    }
  }

// ----------------------------------------------------------
}
