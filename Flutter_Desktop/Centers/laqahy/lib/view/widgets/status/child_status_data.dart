import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

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
  Widget build(BuildContext context) {
    return Form(
      key: csc.createChildStatusDataFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اســـم الأم',
                    style: MyTextStyles.font16BlackBold,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Constants().mothersDropdownMenu(),
                ],
              ),
              const SizedBox(
                width: 25,
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
        ],
      ),
    );
  }
}
