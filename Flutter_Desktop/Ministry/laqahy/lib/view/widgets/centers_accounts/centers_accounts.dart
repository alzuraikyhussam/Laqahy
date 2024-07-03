import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/centers_accounts_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/centers_accounts/add_office_account.dart';
import 'package:laqahy/view/widgets/centers_accounts/centers_data_table_source.dart';
import 'package:laqahy/view/widgets/centers_accounts/offices_data_table_source.dart';

class CentersAccounts extends StatelessWidget {
  const CentersAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    CentersAccountsController cac = Get.put(CentersAccountsController());

    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset('assets/images/vaccines-background.png'),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: Get.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'المراكــز الصحيــة',
                        style: MyTextStyles.font18WhiteBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: myIconButton(
                        icon: Icons.refresh_rounded,
                        onTap: () {
                          cac.fetchOffices();
                          cac.handleRadioValueChange('all');
                          cac.fetchCenters();
                        },
                        gradientColors: [
                          MyColors.primaryColor,
                          MyColors.secondaryColor,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return cac.isCentersLoading.value
                    ? SizedBox(
                        width: Get.width,
                        height: 500,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تصفية نتائج البحث:',
                                  style: MyTextStyles.font16PrimaryBold,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: RadioListTile(
                                        mouseCursor:
                                            MaterialStateMouseCursor.clickable,
                                        title: Text(
                                          'كــافة المــراكز',
                                          style: MyTextStyles.font16BlackMedium,
                                        ),
                                        value: 'all',
                                        groupValue: cac.selectedOption.value,
                                        onChanged: cac.handleRadioValueChange,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        mouseCursor:
                                            MaterialStateMouseCursor.clickable,
                                        title: Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'المـراكز التي تتبع: ',
                                              style: MyTextStyles
                                                  .font16BlackMedium,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 280,
                                              height: 50,
                                              child: cac
                                                  .registeredOfficesDropdownMenu(),
                                            )
                                          ],
                                        ),
                                        value: 'centersByOffice',
                                        groupValue: cac.selectedOption.value,
                                        onChanged: cac.handleRadioValueChange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 500,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: PaginatedDataTable2(
                              autoRowsToHeight: true,
                              empty: ApiExceptionWidgets().myDataNotFound(
                                onPressedRefresh: () {
                                  if (cac.selectedOption.value == 'all') {
                                    cac.fetchCenters();
                                  } else if (cac.selectedOption.value ==
                                      'centersByOffice') {
                                    cac.fetchRegisteredOfficesInDropDownMenu();
                                    if (cac.registeredOfficesDropDownMenu
                                            .isNotEmpty &&
                                        cac.selectedRegisteredOfficeId.value !=
                                            null) {
                                      cac.fetchCentersByOffice(cac
                                          .selectedRegisteredOfficeId.value!);
                                    }
                                  }
                                },
                              ),
                              horizontalMargin: 15,
                              headingRowColor: MaterialStatePropertyAll(
                                  MyColors.primaryColor),
                              // sortColumnIndex: 1,
                              // sortAscending: cac.sort.value,
                              showFirstLastButtons: true,
                              columnSpacing: 5,
                              // rowsPerPage: 5,
                              controller: cac.centersTableController,
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
                                    cac.centersTableController.goToFirstPage();
                                    print(cac.officesTableController
                                        .currentRowIndex);
                                  },
                                  hintText: 'اكتــب هنــا للبحـــث',
                                  prefixIcon: Icons.search,
                                  controller: cac.centersSearchController,
                                  keyboardType: TextInputType.text,
                                  onChanged: cac.filterCenters,
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
                                      "اســم المــركز",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // onSort: (columnIndex, ascending) {
                                  //   cac.sort.value = ascending;
                                  //   cac.onSortColum(columnIndex, ascending);
                                  // },
                                  fixedWidth: 220,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "المحـافظة",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 50,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "المـديرية",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 50,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "رقـم الهــاتف",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 120,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "تاريـخ الإنضمـام",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 60,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "العنــوان",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 60,
                                ),
                              ],
                              source: CentersAccountsRowSource(
                                myData: cac.filteredCenters,
                                count: cac.filteredCenters.length,
                              ),
                            ),
                          ),
                        ],
                      );
              }),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: Get.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MyColors.primaryColor,
                            MyColors.secondaryColor,
                          ],
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'مكــاتب الصحــة والسكــان',
                        style: MyTextStyles.font18WhiteBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return cac.isOfficesLoading.value
                    ? SizedBox(
                        width: Get.width,
                        height: 500,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsetsDirectional.only(
                          bottom: 50,
                        ),
                        height: 500,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: PaginatedDataTable2(
                          autoRowsToHeight: true,
                          empty: ApiExceptionWidgets().myDataNotFound(
                            onPressedRefresh: () {
                              cac.fetchOffices();
                            },
                          ),
                          horizontalMargin: 15,
                          headingRowColor:
                              MaterialStatePropertyAll(MyColors.primaryColor),
                          // sortColumnIndex: 1,
                          // sortAscending: cac.sort.value,
                          showFirstLastButtons: true,
                          columnSpacing: 5,
                          // rowsPerPage: 5,
                          controller: cac.officesTableController,
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
                                cac.officesTableController.goToFirstPage();
                                print(
                                    cac.officesTableController.currentRowIndex);
                              },
                              hintText: 'اكتــب هنــا للبحـــث',
                              prefixIcon: Icons.search,
                              controller: cac.officeSearchController,
                              keyboardType: TextInputType.text,
                              onChanged: cac.filterOffices,
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
                                  "اســم المـكتب",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              // onSort: (columnIndex, ascending) {
                              //   cac.sort.value = ascending;
                              //   cac.onSortColum(columnIndex, ascending);
                              // },
                              fixedWidth: 220,
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "كود التسجيل",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "عـدد المـراكز",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "رقـم الهــاتف",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              // fixedWidth: 120,
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "تاريـخ الإنضمـام",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              // fixedWidth: 60,
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "العنــوان",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              // fixedWidth: 60,
                            ),
                            DataColumn2(
                              label: Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  "العمليـات",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              fixedWidth: 120,
                            ),
                          ],
                          source: OfficesAccountsRowSource(
                            myData: cac.filteredOffices,
                            count: cac.filteredOffices.length,
                          ),
                          actions: [
                            myButton(
                              onPressed: () {
                                cac.clearTextFields();
                                myShowDialog(
                                    context: context,
                                    widgetName: AddOfficeAccount());
                              },
                              text: 'إضــافة مكـتب جـديــد',
                              textStyle: MyTextStyles.font16WhiteBold,
                            ),
                          ],
                        ),
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
