import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_visit_controller.dart';

import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/mother_visit_data_table.dart';

class MotherVisitData extends StatefulWidget {
  const MotherVisitData({super.key});

  @override
  State<MotherVisitData> createState() => _MotherVisitDataState();
}

class _MotherVisitDataState extends State<MotherVisitData> {
  bool isChecked = false;

  MotherVisitController mvc = Get.put(MotherVisitController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاســم',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    prefixIcon: Icons.woman_2_outlined,
                    width: 300,
                    hintText: 'اســم الأم',
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحلــة الـجرعــة',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<MotherVisitController>(
                    builder: (controller) {
                      return myDropDownMenuButton(
                        width: 280,
                        hintText: 'اختر مرحـلة الجــرعة',
                        items: controller.dosageLevels,
                        onChanged: (String? value) {
                          controller.changeDosageLevelSelectedValue(value!);
                        },
                        searchController:
                            controller.dosageLevelSearchController.value,
                        selectedValue: controller.dosageLevelSelectedValue,
                      );
                    },
                  ),
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
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  myCheckBox(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    onChanged: (selected) {
                      setState(() {
                        isChecked = selected;
                      });
                    },
                    value: isChecked,
                    text: 'الأولى',
                  ),
                  myCheckBox(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    onChanged: (selected) {
                      setState(() {
                        isChecked = selected;
                      });
                    },
                    value: isChecked,
                    text: 'الثانية',
                  ),
                  myCheckBox(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    onChanged: (selected) {
                      setState(() {
                        isChecked = selected;
                      });
                    },
                    value: isChecked,
                    text: 'الثالثة',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              myButton(
                onPressed: () {},
                text: 'إضــافــة',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 130,
              ),
              SizedBox(
                width: 15,
              ),
              myButton(
                onPressed: () {
                  hlc.changeChoose(
                    'الرئيسية',
                  );
                },
                text: 'خـــــروج',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 130,
                backgroundColor: MyColors.greyColor,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                bottom: 50,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Obx(
                () {
                  return PaginatedDataTable2(
                    autoRowsToHeight: true,
                    empty: Center(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset('assets/images/No data.svg'),
                      ),
                    ),
                    horizontalMargin: 15,
                    headingRowColor:
                        MaterialStatePropertyAll(MyColors.primaryColor),
                    sortColumnIndex: 0,
                    sortAscending: mvc.sort.value,
                    showFirstLastButtons: true,
                    columnSpacing: 5,
                    // rowsPerPage: 8,
                    headingRowDecoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                      ),
                    ),
                    header: Container(
                      width: double.infinity,
                      // padding: EdgeInsetsDirectional.all(5),
                      child: myTextField(
                        onTap: () {},
                        hintText: 'اكتــب هنــا للبحـــث',
                        prefixIcon: Icons.search,
                        controller: mvc.motherVisitSearchController,
                        keyboardType: TextInputType.text,
                        onChanged: mvc.filterMotherVisitData,
                      ),
                    ),
                    columns: [
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "نـوع الجـرعة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        onSort: (columnIndex, ascending) {
                          mvc.sort.value = ascending;
                          mvc.onSortColum(columnIndex, ascending);
                        },
                        fixedWidth: 150,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "المـركز الصـحي",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "العـامل الصـحي",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        // fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "تاريـخ أخـذ الجرعـة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "تاريـخ العـودة",
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                        fixedWidth: 200,
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
                    source: MotherVisitRowSource(
                      myData: mvc.myMotherVisitFilteredData,
                      count: mvc.myMotherVisitFilteredData.length,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
