import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_visit_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';

import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/api_erxception_alert.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/visits/child_visit/child_visit_data_table.dart';

class ChildVisitData extends StatefulWidget {
  const ChildVisitData({super.key});

  @override
  State<ChildVisitData> createState() => _ChildVisitDataState();
}

class _ChildVisitDataState extends State<ChildVisitData> {
  bool isChecked = false;
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  ChildVisitController cvc = Get.put(ChildVisitController());
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  void initState() {
    cvc.clearTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: cvc.createChildStatementDataFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اســم الأم',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().allMothersDropdownMenu(),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اســـم الطـفــل',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().childsDropdownMenu(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'فــترة الـزيـــارة',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().visitTypeDropdownMenu(),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نـــوع الـلقـــاح',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().vaccineWithVisitDropdownMenu(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نـــوع الـجرعــة',
                        style: MyTextStyles.font16PrimaryBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Constants().dosageWithVaccineDropdownMenu(),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return cvc.isAddLoading.value
                            ? myLoadingIndicator(
                                width: 150,
                              )
                            : myButton(
                                width: 150,
                                onPressed: cvc.isAddLoading.value
                                    ? null
                                    : () {
                                        if (cvc.createChildStatementDataFormKey
                                            .currentState!
                                            .validate()) {
                                          cvc.addChildrenStatement();
                                          // Get.back();
                                        }
                                        // myShowDialog(
                                        //     context: context,
                                        //     widgetName:
                                        //         const AddUserSuccessfully());
                                      },
                                text: 'اضــافة',
                                textStyle: MyTextStyles.font16WhiteBold);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () {
                if (sdc.selectedChildsId.value == null) {
                  return Container(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 50,
                    ),
                    height: 550,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: PaginatedDataTable2(
                      autoRowsToHeight: true,
                      empty: ApiExceptionWidgets().myDataNotFound(
                        onPressedRefresh: () {
                          if (sdc.selectedChildsId.value == null) {
                            Constants().playErrorSound();
                            myShowDialog(
                              context: Get.context!,
                              widgetName: ApiExceptionAlert(
                                title: 'خطـــأ',
                                description:
                                    'من فضلك، قم باختيار اسم الطفل أولاً',
                                height: 280,
                              ),
                            );
                          } else {
                            cvc.fetchChildrenStatement(
                                sdc.selectedChildsId.value!);
                          }
                        },
                      ),
                      horizontalMargin: 15,
                      headingRowColor:
                          MaterialStatePropertyAll(MyColors.primaryColor),
                      // sortColumnIndex: 1,
                      // sortAscending: uc.sort.value,
                      showFirstLastButtons: true,
                      columnSpacing: 5,
                      // rowsPerPage: 5,
                      controller: cvc.tableController,
                      headingRowDecoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                      header: SizedBox(
                        width: double.infinity,
                        // padding: EdgeInsetsD)irectional.all(5),
                        child: myTextField(
                          onTap: () {
                            cvc.tableController.goToFirstPage();
                            print(cvc.tableController.currentRowIndex);
                          },
                          hintText: 'اكتــب هنــا للبحـــث',
                          prefixIcon: Icons.search,
                          controller: cvc.childStatementSearchController,
                          keyboardType: TextInputType.text,
                          onChanged: cvc.filterChildStatement,
                        ),
                      ),
                      columns: [
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "م",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          fixedWidth: 40,
                          // numeric: true,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'مرحلة الزيارة',
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // onSort: (columnIndex, ascending) {
                          //   uc.sort.value = ascending;
                          //   uc.onSortColum(columnIndex, ascending);
                          // },
                          // fixedWidth: 220,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "نوع اللقاح",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 50,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "نوع الجرعة",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 120,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "تاريخ اخذ الجرعة",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 60,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "تاريخ العودة",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 100,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "العامل الصحي",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          fixedWidth: 220,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "المركز الصحي",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 100,
                        ),
                        DataColumn2(
                          label: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "العمليات",
                              style: MyTextStyles.font14WhiteBold,
                            ),
                          ),
                          // fixedWidth: 130,
                        ),
                      ],
                      source: ChildVisitRowSource(
                        myData: cvc.filteredChildStatement,
                        count: cvc.filteredChildStatement.length,
                      ),
                    ),
                  );
                } else {
                  if (cvc.isLoading.value) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: myLoadingIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: 50,
                      ),
                      height: 550,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: PaginatedDataTable2(
                        autoRowsToHeight: true,
                        empty: ApiExceptionWidgets().myDataNotFound(
                          onPressedRefresh: () {
                            if (sdc.selectedChildsId.value == null) {
                              Constants().playErrorSound();
                              myShowDialog(
                                context: Get.context!,
                                widgetName: ApiExceptionAlert(
                                  title: 'خطـــأ',
                                  description:
                                      'من فضلك، قم باختيار اسم الطفل أولاً',
                                  height: 280,
                                ),
                              );
                            } else {
                              cvc.fetchChildrenStatement(
                                  sdc.selectedChildsId.value!);
                            }
                          },
                        ),
                        horizontalMargin: 15,
                        headingRowColor:
                            MaterialStatePropertyAll(MyColors.primaryColor),
                        // sortColumnIndex: 1,
                        // sortAscending: uc.sort.value,
                        showFirstLastButtons: true,
                        columnSpacing: 5,
                        // rowsPerPage: 5,
                        controller: cvc.tableController,
                        headingRowDecoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10),
                            topEnd: Radius.circular(10),
                          ),
                        ),
                        header: SizedBox(
                          width: double.infinity,
                          // padding: EdgeInsetsD)irectional.all(5),
                          child: myTextField(
                            onTap: () {
                              cvc.tableController.goToFirstPage();
                              print(cvc.tableController.currentRowIndex);
                            },
                            hintText: 'اكتــب هنــا للبحـــث',
                            prefixIcon: Icons.search,
                            controller: cvc.childStatementSearchController,
                            keyboardType: TextInputType.text,
                            onChanged: cvc.filterChildStatement,
                          ),
                        ),
                        columns: [
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "م",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            fixedWidth: 40,
                            // numeric: true,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                'مرحلة الزيارة',
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // onSort: (columnIndex, ascending) {
                            //   uc.sort.value = ascending;
                            //   uc.onSortColum(columnIndex, ascending);
                            // },
                            // fixedWidth: 220,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "نوع اللقاح",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 50,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "نوع الجرعة",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 120,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "تاريخ اخذ الجرعة",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 60,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "تاريخ العودة",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 100,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "العامل الصحي",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            fixedWidth: 220,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "المركز الصحي",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 100,
                          ),
                          DataColumn2(
                            label: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "العمليات",
                                style: MyTextStyles.font14WhiteBold,
                              ),
                            ),
                            // fixedWidth: 130,
                          ),
                        ],
                        source: ChildVisitRowSource(
                          myData: cvc.filteredChildStatement,
                          count: cvc.filteredChildStatement.length,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
