import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class AddMotherStatusData extends StatefulWidget {
  const AddMotherStatusData({super.key});

  @override
  State<AddMotherStatusData> createState() => _AddMotherStatusDataState();
}

class _AddMotherStatusDataState extends State<AddMotherStatusData> {
  StaticDataController sdc = Get.put(StaticDataController());
  MotherStatusDataController msc = Get.put(MotherStatusDataController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
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
            height: 555,
            child: Form(
              key: msc.createMotherStatusDataFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: Text(
                      'اضــافــة بـيــانـات الأم',
                      textAlign: TextAlign.center,
                      style: MyTextStyles.font18PrimaryBold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الاســم الرباعي',
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
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            hintText: 'أدخل الرقم الوطني',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            validator: msc.birthDateValidator,
                            controller: msc.birthDateController,
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
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        prefixIcon: Icons.location_history_outlined,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (msc.isAddLoading.value) {
                          return myLoadingIndicator(
                            width: 150,
                          );
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
                            msc.clearTextFields();
                            Get.back();
                          },
                          text: 'إلغـــاء الأمــــر',
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
