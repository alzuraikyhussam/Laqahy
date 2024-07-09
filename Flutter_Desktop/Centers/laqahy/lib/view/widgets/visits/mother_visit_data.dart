import 'dart:ui';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/visits/mother_visit_data_table.dart';

class MotherVisitData extends StatefulWidget {
  const MotherVisitData({super.key});

  @override
  State<MotherVisitData> createState() => _MotherVisitDataState();
}

class _MotherVisitDataState extends State<MotherVisitData> {
  bool isChecked = false;

  MotherVisitController mvc = Get.put(MotherVisitController());
  StaticDataController sdc = Get.put(StaticDataController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: mvc.createMotherStatementFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم الأم',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Constants().mothersDataDropdownMenu(),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحلــة الـجرعــة',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Constants().dosageLevelDropdownMenu(),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نــوع الـجرعــة',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Constants().dosageTypeDropdownMenu(),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return mvc.isAddLoading.value
                      ? myLoadingIndicator()
                      : myButton(
                          width: 150,
                          onPressed: mvc.isAddLoading.value
                              ? null
                              : () {
                                  if (mvc.createMotherStatementFormKey
                                      .currentState!
                                      .validate()) {
                                    mvc.addMotherStatement();
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
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Obx(
                    () {
                      return mvc.isLoading.value
              ? Center(
                  child: myLoadingIndicator(),
                )
              : Container(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 50,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: PaginatedDataTable2(
                    autoRowsToHeight: true,
                    empty: ApiExceptionWidgets().myDataNotFound(
                      onPressedRefresh: () {
                        mvc.fetchMotherStatement();
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
                    controller: mvc.tableController,
                    headingRowDecoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                      ),
                    ),
                    header: Container(
                      width: double.infinity,
                      // padding: EdgeInsetsD)irectional.all(5),
                      child: myTextField(
                        onTap: () {
                          mvc.tableController.goToFirstPage();
                          print(mvc.tableController.currentRowIndex);
                        },
                        hintText: 'اكتــب هنــا للبحـــث',
                        prefixIcon: Icons.search,
                        controller: mvc.motherStatementSearchController,
                        keyboardType: TextInputType.text,
                        onChanged: mvc.filterMotherStatement,
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
                            "مرحلة الجـرعة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // onSort: (columnIndex, ascending) {
                        //   uc.sort.value = ascending;
                        //   uc.onSortColum(columnIndex, ascending);
                        // },
                        fixedWidth: 220,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "المـركز الصـحي",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 50,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "العـامل الصـحي",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 120,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "تاريـخ أخـذ الجرعـة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 60,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "تاريـخ العـودة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 100,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "العمليـات",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        fixedWidth: 150,
                      ),
                    ],
                    source: MotherVisitRowSource(
                      myData: mvc.filteredMotherStatement,
                      count: mvc.filteredMotherStatement.length,
                    ),
                  ),
                );
                    },
                  ),
            ),
  
            // Expanded(
            //   child: Obx(() {
            //     return mvc.isLoading.value
            //         ? Center(
            //             child: myLoadingIndicator(),
            //           )
            //         : Container(
            //             padding: const EdgeInsetsDirectional.only(
            //               bottom: 50,
            //             ),
            //             width: double.infinity,
            //             decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(10)),
            //             ),
            //             child: Obx(
            //               () {
            //                 return PaginatedDataTable2(
            //                   autoRowsToHeight: true,
            //                   empty: Center(
            //                     child: Container(
            //                       alignment: AlignmentDirectional.center,
            //                       child: SvgPicture.asset(
            //                           'assets/images/No data.svg'),
            //                     ),
            //                   ),
            //                   horizontalMargin: 15,
            //                   headingRowColor: MaterialStatePropertyAll(
            //                       MyColors.primaryColor),
            //                   // sortColumnIndex: 0,
            //                   // sortAscending: mvc.sort.value,
            //                   showFirstLastButtons: true,
            //                   columnSpacing: 5,
            //                   // rowsPerPage: 8,
            //                   headingRowDecoration: const BoxDecoration(
            //                     borderRadius: BorderRadiusDirectional.only(
            //                       topStart: Radius.circular(10),
            //                       topEnd: Radius.circular(10),
            //                     ),
            //                   ),
            //                   header: Container(
            //                     width: double.infinity,
            //                     // padding: EdgeInsetsDirectional.all(5),
            //                     child: myTextField(
            //                       onTap: () {},
            //                       hintText: 'اكتــب هنــا للبحـــث',
            //                       prefixIcon: Icons.search,
            //                       controller:
            //                           mvc.motherStatementSearchController,
            //                       keyboardType: TextInputType.text,
            //                       onChanged: mvc.filterMotherStatement,
            //                     ),
            //                   ),
            //                   columns: [
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "نـوع الجـرعة",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       // onSort: (columnIndex, ascending) {
            //                       //   mvc.sort.value = ascending;
            //                       //   mvc.onSortColum(columnIndex, ascending);
            //                       // },
            //                       fixedWidth: 150,
            //                     ),
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "المـركز الصـحي",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       // fixedWidth: 200,
            //                     ),
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "العـامل الصـحي",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       // fixedWidth: 200,
            //                     ),
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "تاريـخ أخـذ الجرعـة",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       fixedWidth: 200,
            //                     ),
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "تاريـخ العـودة",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       fixedWidth: 200,
            //                     ),
            //                     DataColumn2(
            //                       label: Container(
            //                         alignment: AlignmentDirectional.center,
            //                         child: Text(
            //                           "العمليـات",
            //                           style: MyTextStyles.font14WhiteBold,
            //                         ),
            //                       ),
            //                       fixedWidth: 120,
            //                     ),
            //                   ],
            //                   source: MotherVisitRowSource(
            //                     myData: mvc.filteredMotherStatement,
            //                     count: mvc.filteredMotherStatement.length,
            //                   ),
            //                 );
            //               },
            //             ),
            //           );
            //   }),
            // ),
          
          ],
        ),
      ),
    );
  }
}
