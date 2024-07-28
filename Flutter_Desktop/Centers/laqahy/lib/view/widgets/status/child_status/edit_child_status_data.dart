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
class EditChildStatusData extends StatefulWidget {
  EditChildStatusData({super.key, required this.childData});

  dynamic childData;

  @override
  State<EditChildStatusData> createState() => _EditChildStatusDataState();
}

StaticDataController sdc = Get.put(StaticDataController());
ChildStatusDataController csc = Get.put(ChildStatusDataController());

class _EditChildStatusDataState extends State<EditChildStatusData> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController birthPlaceCon = TextEditingController();
  TextEditingController birthDateCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    sdc.fetchAllMothers();
    sdc.fetchGenders();
    nameCon.text = widget.childData.child_data_name;
    birthPlaceCon.text = widget.childData.child_data_birthplace;
    sdc.selectedAllMothersId.value = widget.childData.mother_data_id;
    sdc.selectedGenderId.value = widget.childData.gender_id;
    birthDateCon.text =
        DateFormat('MMM d, yyyy').format(widget.childData.child_data_birthDate);
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
        height: 400,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: csc.editChildStatusDataFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تعديل بيانات الطفل',
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
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'اسـم الـطفـل',
                              style: MyTextStyles.font16BlackBold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myTextField(
                              controller: nameCon,
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
                            controller: birthPlaceCon,
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
                            controller: birthDateCon,
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
                                    birthDateCon.text =
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
                        if (csc.isUpdateLoading.value) {
                          return myLoadingIndicator(
                            width: 150,
                          );
                        } else {
                          return myButton(
                              width: 150,
                              onPressed: csc.isUpdateLoading.value
                                  ? null
                                  : () {
                                      if (csc.editChildStatusDataFormKey
                                          .currentState!
                                          .validate()) {
                                        csc.updateChildStatusData(
                                          widget.childData.id,
                                          nameCon.text,
                                          birthPlaceCon.text,
                                          birthDateCon.text,
                                          sdc.selectedAllMothersId.value!,
                                          sdc.selectedGenderId.value!,
                                        );
                                      }
                                    },
                              text: 'تعـــديل',
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
