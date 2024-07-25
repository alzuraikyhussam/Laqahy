import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/child_status/add_child_status_data.dart';
import 'package:laqahy/view/widgets/status/child_status/child_status_data_source.dart';

class ChildStatusScreen extends StatefulWidget {
  const ChildStatusScreen({super.key});

  @override
  State<ChildStatusScreen> createState() => _ChildStatusScreenState();
}

class _ChildStatusScreenState extends State<ChildStatusScreen> {
  ChildStatusDataController csc = Get.put(ChildStatusDataController());
  StaticDataController sdc = Get.put(StaticDataController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () {
            if (csc.isLoading.value) {
              return SizedBox(
                height: 350,
                child: Center(
                  child: myLoadingIndicator(),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 50,
                ),
                height: 600,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: PaginatedDataTable2(
                  autoRowsToHeight: true,
                  empty: ApiExceptionWidgets().myDataNotFound(
                    onPressedRefresh: () {
                      csc.fetchAllChildrenStatusData();
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
                  controller: csc.tableController,
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
                        csc.tableController.goToFirstPage();
                        print(csc.tableController.currentRowIndex);
                      },
                      hintText: 'اكتــب هنــا للبحـــث',
                      prefixIcon: Icons.search,
                      controller: csc.childStatusDataSearchController,
                      keyboardType: TextInputType.text,
                      onChanged: csc.filterChildrenStatusData,
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
                          "اسم الطفل",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // onSort: (columnIndex, ascending) {
                      //   uc.sort.value = ascending;
                      //   uc.onSortColum(columnIndex, ascending);
                      // },
                      fixedWidth: 300,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "اسم الأم",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      fixedWidth: 300,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "مكان الميلاد",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      fixedWidth: 200,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "تاريخ الميلاد",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "الجنس",
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
                      fixedWidth: 120,
                    ),
                  ],
                  source: ChildrenStatusDataSource(
                    myData: csc.filteredChildrenStatusData,
                    count: csc.filteredChildrenStatusData.length,
                  ),
                  actions: [
                    myButton(
                      onPressed: () {
                        csc.clearTextFields();
                        myShowDialog(
                            context: context,
                            widgetName: const AddChildStatusData());
                      },
                      text: "إضافة طفل جديد",
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
