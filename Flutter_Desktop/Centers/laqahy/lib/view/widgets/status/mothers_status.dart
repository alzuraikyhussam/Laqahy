import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/add_mother_status_data.dart';
import 'package:laqahy/view/widgets/status/mother_status_data_source.dart';
import 'package:laqahy/view/widgets/users/user_data_table_source.dart';

class MotherStatusScreen extends StatefulWidget {
  const MotherStatusScreen({super.key});

  @override
  State<MotherStatusScreen> createState() => _MotherStatusScreenState();
}

class _MotherStatusScreenState extends State<MotherStatusScreen> {
  MotherStatusDataController msc = Get.put(MotherStatusDataController());
  StaticDataController sdc = Get.put(StaticDataController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () {
            if (msc.isLoading.value) {
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
                      msc.fetchAllMothersStatusData(sdc.centerData.first.id!);
                    },
                  ),
                  horizontalMargin: 15,
                  headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
                  // sortColumnIndex: 1,
                  // sortAscending: uc.sort.value,
                  showFirstLastButtons: true,
                  columnSpacing: 5,
                  // rowsPerPage: 5,
                  controller: msc.tableController,
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
                        msc.tableController.goToFirstPage();
                        print(msc.tableController.currentRowIndex);
                      },
                      hintText: 'اكتــب هنــا للبحـــث',
                      prefixIcon: Icons.search,
                      controller: msc.motherStatusDataSearchController,
                      keyboardType: TextInputType.text,
                      onChanged: msc.filterMotherStatusData,
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
                          "اسم الأم",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 50,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "الرقم الوطني",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 120,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "رقم الهاتف",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "تاريخ الميلاد",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 100,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "المحافظة",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 100,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "المديرية",
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
                  source: MotherStatusDataSource(
                    myData: msc.filteredMothersStatusData,
                    count: msc.filteredMothersStatusData.length,
                  ),
                  actions: [
                        myButton(
                          onPressed: () {
                            sdc.selectedGenderId.value = null;
                            sdc.selectedPermissionId.value = null;
                            msc.clearTextFields();
                            myShowDialog(context: context, widgetName: AddMotherStatement());
                          },
                          text: 'إضــافة مستخـدم جـديــد',
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
