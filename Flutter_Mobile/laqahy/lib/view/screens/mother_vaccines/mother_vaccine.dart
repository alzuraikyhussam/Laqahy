import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/mother_vaccine_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/mother_vaccines/mother_vaccine_data_table_source.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class MotherVaccine extends StatefulWidget {
  const MotherVaccine({super.key});

  @override
  State<MotherVaccine> createState() => _MotherVaccineState();
}

class _MotherVaccineState extends State<MotherVaccine> {
  @override
  void initState() {
    mvc.fetchMotherDosageDataTable();
    super.initState();
  }

  MotherVaccineController mvc = Get.put(MotherVaccineController());

  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          text: 'لقاحات الأم',
          onTap: () {
            Get.back();
            // Get.delete<MotherVaccineController>();
          }),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          return mvc.isLoading.value
              ? SizedBox(
                  width: Get.width,
                  child: Center(
                    child: myLoadingIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: MyColors.secondaryColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: 360,
                                  height: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'مرحباً بك',
                                        style: MyTextStyles.font14PrimaryBold,
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(
                                        sdc.userLoggedData.first.user
                                                .motherName ??
                                            'مجهول الهوية',
                                        style: MyTextStyles.font16BlackBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 30,
                              top: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15)),
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 35,
                                      height: 35,
                                      child: Icon(
                                        Icons.child_care_outlined,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      'عدد الأطفال',
                                      style: MyTextStyles.font14PrimaryBold,
                                    ),
                                    Divider(
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: MyColors.primaryColor,
                                      height: 3,
                                    ),
                                    Text(
                                        '${sdc.userLoggedData.first.childrenCount ?? 0}'),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 140,
                              top: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15)),
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 35,
                                      height: 35,
                                      child: Icon(
                                        Icons.date_range_outlined,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      'موعد العودة',
                                      style: MyTextStyles.font14PrimaryBold,
                                    ),
                                    Divider(
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: MyColors.primaryColor,
                                      height: 3,
                                    ),
                                    Text(DateFormat('yyyy-MM-dd').format(
                                        sdc.userLoggedData.first.returnDate ??
                                            DateTime.now()))
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              child: Image.asset(
                                'assets/images/mother-vaccine.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
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
                                  height: 45,
                                  width: 150,
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
                                    'ملخص الللقاحات',
                                    style: MyTextStyles.font16WhiteBold,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 145,
                            margin: const EdgeInsetsDirectional.only(
                              start: 15,
                              end: 15,
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: DataTable2(
                              dataRowHeight: 50,
                              headingRowHeight: 45,
                              empty: ApiExceptionWidgets().myDataNotFound(
                                onPressedRefresh: () {
                                  mvc.fetchMotherDosageDataTable();
                                },
                              ),
                              horizontalMargin: 7,
                              // headingTextStyle: MyTextStyles.font14WhiteBold,
                              headingRowColor: MaterialStatePropertyAll(
                                  MyColors.primaryColor),
                              columnSpacing: 3,
                              headingRowDecoration: const BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(10),
                                  topEnd: Radius.circular(10),
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
                                  fixedWidth: 15,
                                  // numeric: true,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "مرحلة الجرعة",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 140,
                                  // onSort: (columnIndex, ascending) {
                                  //   uc.sort.value = ascending;
                                  //   uc.onSortColum(columnIndex, ascending);
                                  // },
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "عدد الجُرع",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                  // fixedWidth: 50,
                                ),
                                DataColumn2(
                                  label: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      "الجُرع المأخوذة",
                                      style: MyTextStyles.font14WhiteBold,
                                    ),
                                  ),
                                ),
                              ],
                              rows: getMotherDosageRowSource(
                                myData: mvc.motherVaccine,
                                count: mvc.motherVaccine.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
