import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/accounts_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/accounts/add_center_account.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/accounts/centers_data_table_source.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountsController cac = Get.put(AccountsController());
    StaticDataController sdc = Get.find<StaticDataController>();

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
                      width: 230,
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
                        'حســابات المراكــز الصحيــة',
                        style: MyTextStyles.font18WhiteBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: myIconButton(
                        icon: Icons.refresh_rounded,
                        onTap: () {
                          cac.fetchCenters();
                          sdc.fetchDirectorates(sdc.officeData.first.cityId!);
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
              const SizedBox(
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
                    : Container(
                        margin: const EdgeInsetsDirectional.only(
                          bottom: 50,
                        ),
                        height: 500,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: PaginatedDataTable2(
                          autoRowsToHeight: true,
                          empty: ApiExceptionWidgets().myDataNotFound(
                            onPressedRefresh: () {
                              cac.fetchCenters();
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
                                  "كود التسجيـل",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
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
                                  "تاريـخ التسجيـل",
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
                              fixedWidth: 100,
                            ),
                          ],
                          source: CentersAccountsRowSource(
                            myData: cac.filteredCenters,
                            count: cac.filteredCenters.length,
                          ),
                          actions: [
                            myButton(
                              onPressed: () {
                                cac.clearTextFields();
                                myShowDialog(
                                  context: context,
                                  widgetName: const AddCenterAccount(),
                                );
                              },
                              text: 'إضــافة مــركز جـديــد',
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
