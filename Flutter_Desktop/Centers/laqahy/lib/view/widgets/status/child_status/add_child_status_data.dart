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
        height: 500,
        child: Form(
          key: csc.createChildStatusDataFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: Text(
                  'إضـــافــــة بيانات الطفل',
                  textAlign: TextAlign.center,
                  style: MyTextStyles.font18PrimaryBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'اسم الأم',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Constants().allMothersDropdownMenu(),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'تاريخ الميلاد',
                        style: MyTextStyles.font16BlackBold,
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
                        ),
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
                        height: 3,
                      ),
                      Constants().gendersDropdownMenu(),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (csc.isAddLoading.value) {
                      return myLoadingIndicator();
                    } else {
                      return myButton(
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
                        csc.clearTextFields();
                        Get.back();
                      },
                      text: 'إلغـــاء اللأمــر',
                      textStyle: MyTextStyles.font16WhiteBold),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
