import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/child_status_data_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class AddChildStatusData extends StatefulWidget {
  const AddChildStatusData({super.key});

  @override
  State<AddChildStatusData> createState() => _AddChildStatusDataState();
}

class _AddChildStatusDataState extends State<AddChildStatusData> {
  StaticDataController sdc = Get.put(StaticDataController());
  ChildStatusDataController csc = Get.put(ChildStatusDataController());

  @override
  void initState() {
    sdc.fetchAllMothers();
    sdc.fetchGenders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      contentPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: MyColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 450,
        child: Center(
          child: Form(
            key: csc.createChildStatusDataFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'إضـافة بيانات الطفل',
                    textAlign: TextAlign.center,
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'اسم الأم',
                              style: MyTextStyles.font16BlackBold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Constants().allMothersDropdownMenu(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'اسـم الطفـل',
                              style: MyTextStyles.font16BlackBold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myTextField(
                              controller: csc.nameController,
                              validator: csc.nameValidator,
                              prefixIcon: Icons.child_care_rounded,
                              width: 300,
                              hintText: 'اســم الــطفــل',
                              keyboardType: TextInputType.text,
                              readOnly: false,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            width: 200,
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
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الـجـنـس',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().gendersDropdownMenu(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (csc.isAddLoading.value) {
                          return myLoadingIndicator(width: 150);
                        } else {
                          return myButton(
                              width: 150,
                              onPressed: csc.isAddLoading.value
                                  ? null
                                  : () {
                                      if (csc.createChildStatusDataFormKey
                                          .currentState!
                                          .validate()) {
                                        csc.addChildStatusData();
                                      }
                                    },
                              text: 'إضـــافــــة',
                              textStyle: MyTextStyles.font16WhiteBold);
                        }
                      }),
                      const SizedBox(
                        width: 20,
                      ),
                      myButton(
                          width: 150,
                          backgroundColor: MyColors.greyColor,
                          onPressed: () {
                            Get.back();
                            csc.clearTextFields();
                          },
                          text: 'إلغـــاء الأمــر',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
