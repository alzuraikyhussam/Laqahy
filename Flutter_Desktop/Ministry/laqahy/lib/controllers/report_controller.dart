import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/utils/centers_pdf_generator.dart';
import 'package:laqahy/core/utils/status_pdf_generator.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/models/child_data_model.dart';
import 'package:laqahy/models/home_layout_model.dart';
import 'package:laqahy/models/mother_data_model.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:laqahy/models/report_card_model.dart';
import 'package:laqahy/models/status_type_model.dart';
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
  onInit() async {
    fetchRegisteredOfficesInDropDownMenu();
    await fetchMinMaxStatusDates();
    super.onInit();
  }

  StaticDataController sdc = Get.find<StaticDataController>();

  Constants cons = Constants();

  var centers = <HealthyCenter>[].obs;
  var isGenerateCentersReportLoading = false.obs;

  var adminData = <User>[].obs;
  var isFetchAdminDataLoading = false.obs;

  var registeredOfficesDropDownMenu = <Office>[].obs;
  var selectedRegisteredOffice = Rx<Office?>(null);
  var registeredOfficeErrorMsg = ''.obs;
  var isRegisteredOfficesDropDownMenuLoading = false.obs;
  TextEditingController registeredOfficeDropDownMenuSearchController =
      TextEditingController();

  List<ReportCardItem> reportsCardItems = [
    ReportCardItem(
      imageName: 'assets/icons/status-icon.png',
      title: 'تقرير عن الحالات',
      onPressed: const CreateStatusReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/centers-icon.png',
      title: 'تقرير عن المراكز الصحية',
      onPressed: const CreateCentersReportDialog(),
    ),
    ReportCardItem(
      imageName: 'assets/icons/vaccines-icon.png',
      title: 'تقرير عن اللقاحات',
      onPressed: const CreateVaccineReportDialog(),
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
            cons.errorAudio();

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
            cons.errorAudio();

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
      var response = await http.get(
        Uri.parse(
            '${ApiEndpoints.getCentersReport}/${selectedRegisteredOffice.value!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'] as List;
        centers.value = jsonData.map((e) => HealthyCenter.fromJson(e)).toList();

        if (adminData.isEmpty) {
          await fetchAdminData();
        }
        await generateCentersReportPdf(Get.context!);

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
        officeName: selectedRegisteredOffice.value!.id == 0
            ? 'جميع مكاتب الصحة والسكان'
            : centers.first.officeName,
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

// ----------------------------------------------------------

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

  /////////////

  String? statusTypeValidator(value) {
    if (value == null) {
      return 'قم باختيار نوع الحالة';
    }
    return null;
  }

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
            cons.errorAudio();
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
            cons.errorAudio();
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
            cons.errorAudio();

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
            cons.errorAudio();

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
            cons.errorAudio();

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

        if (adminData.isEmpty) {
          await fetchAdminData();
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

        if (adminData.isEmpty) {
          await fetchAdminData();
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

        if (adminData.isEmpty) {
          await fetchAdminData();
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
          managerName: adminData.first.name,
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
          managerName: adminData.first.name,
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
}
