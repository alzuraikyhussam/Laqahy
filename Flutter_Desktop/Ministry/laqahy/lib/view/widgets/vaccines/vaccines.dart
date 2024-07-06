import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/vaccines/vaccine_data_table_source.dart';

class VaccinesScreen extends StatefulWidget {
  const VaccinesScreen({super.key});

  @override
  State<VaccinesScreen> createState() => _VaccinesScreenState();
}

class _VaccinesScreenState extends State<VaccinesScreen> {
  VaccineController vc = Get.put(VaccineController());

  @override
  Widget build(BuildContext context) {
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
              Obx(() {
                return FutureBuilder(
                  future: vc.fetchDataFuture.value,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: Get.width,
                        height: 300,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: ApiExceptionWidgets().mySnapshotError(
                            snapshot.error, onPressedRefresh: () {
                          vc.fetchVaccinesQuantity();
                        }),
                      );
                    } else {
                      if (vc.vaccines.isEmpty) {
                        return Center(
                          child: ApiExceptionWidgets().myDataNotFound(
                            onPressedRefresh: () {
                              vc.fetchVaccinesQuantity();
                            },
                          ),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: vc.vaccines.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 120,
                          ),
                          itemBuilder: (context, index) {
                            return myVaccineCards(
                              id: vc.vaccines[index].vaccineTypeId!,
                              title: vc.vaccines[index].vaccineType!,
                              quantity: vc.vaccines[index].quantity!,
                            );
                          },
                        );
                      }
                    }
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return vc.isTableLoading.value
                    ? SizedBox(
                        width: Get.width,
                        height: 600,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10),
                                      topEnd: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        MyColors.primaryColor,
                                        MyColors.secondaryColor,
                                      ],
                                      begin: AlignmentDirectional.topCenter,
                                      end: AlignmentDirectional.bottomCenter,
                                    ),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10),
                                      topEnd: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'حركــة المخــزون',
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
                                      vc.fetchVaccinesQuantity();
                                      vc.fetchVaccinesStatement();
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
                          Container(
                            height: 500,
                            padding: const EdgeInsetsDirectional.only(
                              bottom: 50,
                            ),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: PaginatedDataTable2(
                              autoRowsToHeight: true,
                              empty: ApiExceptionWidgets().myDataNotFound(
                                onPressedRefresh: () {
                                  vc.fetchVaccinesStatement();
                                },
                              ),
                              horizontalMargin: 15,
                              headingRowColor: MaterialStatePropertyAll(
                                  MyColors.primaryColor),
                              // sortColumnIndex: 1,
                              // sortAscending: uc.sort.value,
                              showFirstLastButtons: true,
                              columnSpacing: 5,
                              // rowsPerPage: 5,
                              controller: vc.tableController,
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
                                    vc.tableController.goToFirstPage();
                                  },
                                  hintText: 'اكتــب هنــا للبحـــث',
                                  prefixIcon: Icons.search,
                                  controller: vc.vaccineSearchController,
                                  keyboardType: TextInputType.text,
                                  onChanged: vc.filterVaccines,
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
                                      "اسـم اللقـاح",
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
                                      "الجهـة المانحـة",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 50,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "الكميـة",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  fixedWidth: 50,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "التاريـخ",
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
                                  fixedWidth: 150,
                                ),
                              ],
                              source: VaccineRowSource(
                                myData: vc.filteredVaccines,
                                count: vc.filteredVaccines.length,
                              ),
                            ),
                          ),
                        ],
                      );
              })
            ],
          ),
        ),
      ],
    );
  }
}
