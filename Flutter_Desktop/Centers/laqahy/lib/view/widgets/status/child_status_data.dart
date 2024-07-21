import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/child_status_data_source.dart';

class ChildStatusData extends StatefulWidget {
  const ChildStatusData({super.key});

  @override
  State<ChildStatusData> createState() => _ChildStatusDataState();
}

class _ChildStatusDataState extends State<ChildStatusData> {
  bool isChecked = false;

  ChildStatusDataController csc = Get.put(ChildStatusDataController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());

  @override
  void initState() {
    csc.clearTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: csc.createChildStatusDataFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
<<<<<<< Updated upstream
                  Text(
                    'اســـم الأم',
                    style: MyTextStyles.font16BlackBold,
=======
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
                      Constants().mothersDropdownMenu(),
                    ],
>>>>>>> Stashed changes
                  ),
                  const SizedBox(
<<<<<<< Updated upstream
                    width: 25,
=======
                    height: 10,
>>>>>>> Stashed changes
                  ),
<<<<<<< Updated upstream
                  Constants().mothersDropdownMenu(),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اســم الــطفــل',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    controller: csc.nameController,
                    validator: csc.nameValidator,
                    prefixIcon: Icons.child_care,
                    width: 300,
                    hintText: 'اســم الــطفــل',
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    onChanged: (value) {},
                  ),
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
                    'مـكـان الـميـلاد',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    controller: csc.birthPlaceController,
                    validator: csc.birthPlaceValidator,
                    prefixIcon: Icons.place_outlined,
                    width: 200,
                    hintText: 'مـكـان الـميـلاد',
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    onChanged: (value) {},
=======
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اســم الــطفــل',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: csc.nameController,
                        validator: csc.nameValidator,
                        prefixIcon: Icons.child_care,
                        width: 300,
                        hintText: 'اســم الــطفــل',
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        onChanged: (value) {},
                      ),
                    ],
>>>>>>> Stashed changes
                  ),
                ],
              ),
              const SizedBox(
<<<<<<< Updated upstream
                height: 20,
=======
                width: 20,
>>>>>>> Stashed changes
              ),
              Row(
                children: [
<<<<<<< Updated upstream
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مـحـل الـميـلاد',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: csc.birthPlaceController,
                        validator: csc.birthPlaceValidator,
                        prefixIcon: Icons.place_outlined,
                        width: 200,
                        hintText: 'مـكـان الـميـلاد',
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تاريخ الميلاد',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        child: myTextField(
                          validator: csc.birthDateValidator,
                          controller: csc.birthDateController,
                          hintText: 'تاريــخ الميـلاد',
                          prefixIcon: Icons.date_range_outlined,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          width: 250,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now())
                                .then(
                              (value) {
                                if (value == null) {
                                  return;
                                } else {
                                  csc.birthDateController.text =
                                      DateFormat.yMMMd().format(value);
                                }
                              },
                            );
                          },
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الـجـنـس',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Constants().gendersDropdownMenu(),
                    ],
=======
                  Text(
                    'تاريخ الميلاد',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    validator: csc.birthDateValidator,
                    controller: csc.birthDateController,
                    hintText: 'تاريــخ الميـلاد',
                    prefixIcon: Icons.date_range_outlined,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    width: 250,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now())
                          .then(
                        (value) {
                          if (value == null) {
                            return;
                          } else {
                            csc.birthDateController.text =
                                DateFormat.yMMMd().format(value);
                          }
                        },
                      );
                    },
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الـجـنـس',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
>>>>>>> Stashed changes
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return csc.isAddLoading.value
                    ? myLoadingIndicator()
                    : myButton(
                        width: 150,
                        onPressed: csc.isAddLoading.value
                            ? null
                            : () {
                                if (csc
                                    .createChildStatusDataFormKey.currentState!
                                    .validate()) {
                                  csc.addChildStatusData();
                                }
                              },
                        text: 'اضــافة',
                        textStyle: MyTextStyles.font16WhiteBold);
              }),
              const SizedBox(
                  height: 20,
                ),
                Obx(
                  () {
                    if (csc.isLoading.value) {
                      return SizedBox(
                        height: 550,
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
                              fixedWidth: 220,
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
                                  "مكان الميلاد",
                                  style: MyTextStyles.font14WhiteBold,
                                ),
                              ),
                              // fixedWidth: 120,
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
                              // fixedWidth: 130,
                            ),
                          ],
                          source: ChildrenStatusDataSource(
                            myData: csc.filteredChildrenStatusData,
                            count: csc.filteredChildrenStatusData.length,
                          ),
                        ),
                      );
                    }
                  },
                ),
              
            ],
          ),
<<<<<<< Updated upstream
        ),
      
=======
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الـمـحافـظة',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Constants().citiesDropdownMenu(),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الـمـديريـة',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Constants().directoratesDropdownMenu(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return csc.isAddLoading.value
                ? myLoadingIndicator()
                : myButton(
                    width: 150,
                    onPressed: csc.isAddLoading.value
                        ? null
                        : () {
                            if (csc.createChildStatusDataFormKey.currentState!
                                .validate()) {
                              csc.addChildStatusData();
                            }
                          },
                    text: 'اضــافة',
                    textStyle: MyTextStyles.font16WhiteBold);
          }),
        ],
>>>>>>> Stashed changes
      ),
    );
  }
}
