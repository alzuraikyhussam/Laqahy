import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/child_vaccine_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/screens/child_vaccines/child_vaccine_data_table_source.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class ChildVaccineScreen extends StatefulWidget {
  const ChildVaccineScreen({
    super.key,
  });

  @override
  State<ChildVaccineScreen> createState() => _ChildVaccineScreenState();
}

class _ChildVaccineScreenState extends State<ChildVaccineScreen> {
  ChildVaccineController cvc = Get.put(ChildVaccineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'لقاحات الطفل', onTap: () => Get.back()),
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
        child: SingleChildScrollView(
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
                            color: MyColors.secondaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 360,
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'لقاحات طفلك',
                                style: MyTextStyles.font14PrimaryBold,
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                cvc.childData.value.childName ?? 'مجهول الهوية',
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
                        width: 70,
                        height: 100,
                        padding: const EdgeInsetsDirectional.only(
                          top: 5,
                          bottom: 5,
                          start: 2,
                          end: 2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.2),
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
                              'العمر',
                              style: MyTextStyles.font14PrimaryBold,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Divider(
                              thickness: 3,
                              indent: 25,
                              endIndent: 25,
                              color: MyColors.primaryColor,
                              height: 3,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  '${cvc.childData.value.age}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 105,
                      top: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: 100,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.2),
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
                                cvc.childData.value.returnDate ??
                                    DateTime.now())),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 210,
                      top: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: 70,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.2),
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
                              'الجنس',
                              style: MyTextStyles.font14PrimaryBold,
                            ),
                            Divider(
                              thickness: 3,
                              indent: 25,
                              endIndent: 25,
                              color: MyColors.primaryColor,
                              height: 3,
                            ),
                            Text(
                              cvc.childData.value.gender ?? 'مجهول',
                            ),
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
              Obx(() {
                return cvc.isLoading.value
                    ? SizedBox(
                        width: Get.width,
                        height: 320,
                        child: Center(
                          child: myLoadingIndicator(),
                        ),
                      )
                    : Column(
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
                          SingleChildScrollView(
                            child: Container(
                              height: 320,
                              margin: const EdgeInsetsDirectional.only(
                                start: 15,
                                bottom: 30,
                                end: 15,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: MyColors.primaryColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: DataTable2(
                                dataRowHeight: 50,
                                headingRowHeight: 45,
                                empty: ApiExceptionWidgets().myDataNotFound(
                                  onPressedRefresh: () {
                                    cvc.fetchChildVaccineDataTable(
                                        cvc.childData.value.id!);
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
                                        "اسم اللقاح",
                                        style: MyTextStyles.font14WhiteBold,
                                      ),
                                    ),
                                    fixedWidth: 160,
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
                                rows: getChildVaccineRowSource(
                                  myData: cvc.childVaccines,
                                  count: cvc.childVaccines.length,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
