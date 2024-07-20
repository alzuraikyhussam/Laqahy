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
    nameCon.text = widget.childData.child_data_name;
    birthPlaceCon.text = widget.childData.child_data_birthplace;
    // sdc.selectedMothersId.value = widget.childData.mother_data_id;
    // sdc.selectedGenderId.value = widget.childData.gender_id;
    birthDateCon.text = DateFormat('MMM d, yyyy').format(widget.childData.child_data_birthDate);
  }

  @override
  Widget build(BuildContext context) {
    nameCon.text = widget.childData.child_data_name;
    birthPlaceCon.text = widget.childData.child_data_birthplace;
    // sdc.selectedMothersId.value = widget.childData.mother_data_id;
    // sdc.selectedGenderId.value = widget.childData.gender_id;
    birthDateCon.text =
        DateFormat('MMM d, yyyy').format(widget.childData.child_data_birthDate);
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
        child: Form(
          key: csc.editChildStatusDataFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                child: Text(
                  'تعديل بيانات الطفل',
                  textAlign: TextAlign.center,
                  style: MyTextStyles.font18PrimaryBold,
                ),
              ),
              const SizedBox(
                height: 30,
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
                      Constants().mothersDropdownMenu(),
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
                        controller: nameCon,
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
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        child: myTextField(
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
                    if (csc.isUpdateLoading.value) {
                      return myLoadingIndicator();
                    } else {
                      return myButton(
                          width: 150,
                          onPressed: csc.isUpdateLoading.value
                              ? null
                              : () {
                                  if (csc
                                      .editChildStatusDataFormKey.currentState!
                                      .validate()) {
                                    csc.updateChildStatusData(
                                      widget.childData.id,
                                      nameCon.text,
                                      birthPlaceCon.text,
                                      birthDateCon.text,
                                      sdc.selectedMothersId.value!,
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
