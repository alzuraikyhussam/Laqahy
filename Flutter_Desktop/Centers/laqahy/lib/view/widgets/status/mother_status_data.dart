import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/mother_status_data_source.dart';

class MotherStatusData extends StatefulWidget {
  const MotherStatusData({super.key});

  @override
  State<MotherStatusData> createState() => _MotherStatusDataState();
}

class _MotherStatusDataState extends State<MotherStatusData> {
  bool isChecked = false;

  MotherStatusDataController msc = Get.put(MotherStatusDataController());
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  void initState() {
    msc.clearTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: msc.createMotherStatusDataFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اســم الأم',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: msc.nameController,
                        validator: msc.nameValidator,
                        prefixIcon: Icons.child_care,
                        width: 300,
                        hintText: "يجب ادخال الاسم الرباعي",
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الرقم الوطني",
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: msc.identityNumberController,
                        validator: msc.identityNumberValidator,
                        prefixIcon: Icons.numbers_outlined,
                        width: 200,
                        hintText: "رقم البطاقة الشخصية",
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "رقم الهاتف",
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: msc.phoneNumberController,
                        validator: msc.phoneNumberValidator,
                        prefixIcon: Icons.phone,
                        width: 200,
                        hintText: "ادخل رقم الهاتف",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تاريخ الميلاد',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        validator: msc.birthDateValidator,
                        controller: msc.birthDateController,
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
                                msc.birthDateController.text =
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
                        'الـمـحافـظة',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Constants().citiesDropdownMenu(),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "المديرية",
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Constants().directoratesDropdownMenu(),
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
                    'المنطقة / العزبة',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    controller: msc.villageController,
                    validator: msc.villageValidator,
                    prefixIcon: Icons.child_care,
                    width: 300,
                    hintText: "قم بادخال اسم المنطقة او العزلة",
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return msc.isAddLoading.value
                    ? myLoadingIndicator()
                    : myButton(
                        width: 150,
                        onPressed: msc.isAddLoading.value
                            ? null
                            : () {
                                if (msc
                                    .createMotherStatusDataFormKey.currentState!
                                    .validate()) {
                                  msc.addMotherStatusData();
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
                  if (msc.isLoading.value) {
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
                            msc.fetchAllMothersStatusData(
                                sdc.centerData.first.id!);
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
                      ),
                    );
                  
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
