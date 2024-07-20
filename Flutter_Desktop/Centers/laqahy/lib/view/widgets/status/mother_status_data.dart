import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/state_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/mother_status_data_source.dart';
import '../../../core/constants/constants.dart';

class MotherStatusData extends StatefulWidget {
  const MotherStatusData({super.key});

  @override
  State<MotherStatusData> createState() => _MotherStatusDataState();
}

class _MotherStatusDataState extends State<MotherStatusData> {
  bool isChecked = false;

  // MotherVisitController mvc = Get.put(MotherVisitController());
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  StateLayoutController slc = Get.put(StateLayoutController());

  @override
  Widget build(BuildContext context) {
    MotherStatusDataController msc = Get.put(MotherStatusDataController());
    StaticDataController sdc = Get.put(StaticDataController());
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: msc.createMotherStatusDataFormKey,
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
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            controller: msc.nameController,
                            validator: msc.nameValidator,
                            prefixIcon: Icons.woman,
                            width: 300,
                            hintText: 'اســم الأم',
                            keyboardType: TextInputType.text,
                            readOnly: false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الرقم الوطني',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            controller: msc.identityNumberController,
                            validator: msc.identityNumberValidator,
                            prefixIcon: Icons.numbers,
                            width: 200,
                            hintText: 'يرجا إدخال الرقم الوطني',
                            keyboardType: TextInputType.text,
                            readOnly: false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            controller: msc.phoneNumberController,
                            validator: msc.phoneNumberValidator,
                            prefixIcon: Icons.phone_enabled_outlined,
                            width: 200,
                            hintText: ' أدخل رقم الهاتف',
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
                            'تاريخ الميلاد',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: myTextField(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الــمنطقــة',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: msc.villageController,
                        validator: msc.villageValidator,
                        prefixIcon: Icons.not_listed_location,
                        width: 300,
                        hintText: 'اســم المنطقة',
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myCheckBox(
                    width: 200,
<<<<<<< Updated upstream
                    hintText: 'الرقم الوطني',
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الهاتف',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  myTextField(
                    controller: mc.phoneNumberController,
                    validator: mc.phoneNumberValidator,
                    prefixIcon: Icons.phone_enabled_outlined,
                    width: 200,
                    hintText: 'رقم الهاتف',
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    onChanged: (value) {},
=======
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                        // print(isChecked);
                      });
                    },
                    onChanged: (selected) {
                      setState(() {
                        isChecked = selected;
                        // print(isChecked);
                      });
                    },
                    value: isChecked,
                    text: 'هـل لـديـك طـفـل؟',
                  ),
                  const SizedBox(
                    height: 25,
>>>>>>> Stashed changes
                  ),
                  Obx(() {
                    if (isChecked) {
                      if (msc.isAddLoading.value) {
                        return myLoadingIndicator();
                      } else {
                        return myButton(
                            width: 150,
                            onPressed: msc.isAddLoading.value
                                ? null
                                : () async {
                                    if (msc.createMotherStatusDataFormKey
                                        .currentState!
                                        .validate()) {
                                      await msc.addMotherStatusData();
                                      slc.onChangedTapState('c');
                                    }
                                  },
                            text: 'اضــافة',
                            textStyle: MyTextStyles.font16WhiteBold);
                      }
                    } else {
                      if (msc.isAddLoading.value) {
                        return myLoadingIndicator();
                      } else {
                        return myButton(
                            width: 150,
                            onPressed: msc.isAddLoading.value
                                ? null
                                : () {
                                    if (msc.createMotherStatusDataFormKey
                                        .currentState!
                                        .validate()) {
                                      msc.addMotherStatusData();
                                    }
                                  },
                            text: 'اضــافة',
                            textStyle: MyTextStyles.font16WhiteBold);
                      }
                    }
                  })
                ],
              ),
            ),
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
<<<<<<< Updated upstream
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'العــزلـة / القـريــة',
                style: MyTextStyles.font16BlackBold,
              ),
              const SizedBox(
                height: 10,
              ),
              myTextField(
                controller: mc.villageController,
                validator: mc.villageValidator,
                prefixIcon: Icons.not_listed_location,
                width: 300,
                hintText: 'العزلة / القرية',
                keyboardType: TextInputType.text,
                readOnly: false,
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          myCheckBox(
            width: 200,
            onTap: () {
              setState(() {
                isChecked = !isChecked;
                // print(isChecked);
              });
            },
            onChanged: (selected) {
              setState(() {
                isChecked = selected;
                // print(isChecked);
              });
            },
            value: isChecked,
            text: 'هـل لـديـك طـفـل؟',
          ),
          const SizedBox(
            height: 25,
          ),
          Obx(() {
              if(isChecked)
              {
                if (mc.isAddLoading.value) {
                  return myLoadingIndicator();
=======
                  );
>>>>>>> Stashed changes
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
                          msc.fetchAllMothersStatusData(sdc.centerData.first.id!);
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
                              "اسم الام",
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
                              "رقم الهاتف",
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
    );
  }
}
