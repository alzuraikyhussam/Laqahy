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
class EditMotherStatusData extends StatefulWidget {
  EditMotherStatusData({super.key, required this.motherData});

  dynamic motherData;

  @override
  State<EditMotherStatusData> createState() => _EditMotherStatusDataState();
}

class _EditMotherStatusDataState extends State<EditMotherStatusData> {
  late TextEditingController nameCon;
  late TextEditingController villageCon;
  late TextEditingController identityNumberCon;
  late TextEditingController phoneCon;
  TextEditingController birthDateCon = TextEditingController();

  StaticDataController sdc = Get.put(StaticDataController());

  @override
  void initState() {
    super.initState();
    nameCon = TextEditingController(text: widget.motherData.mother_name);
    villageCon = TextEditingController(text: widget.motherData.mother_village);
    identityNumberCon =
        TextEditingController(text: widget.motherData.mother_identity_num);
    phoneCon = TextEditingController(text: widget.motherData.mother_phone);

    birthDateCon.text =
        DateFormat('MMM d, yyyy').format(widget.motherData.mother_birthDate);
    sdc.selectedCityId.value = widget.motherData.cities_id;
    sdc.selectedDirectorateId.value = widget.motherData.directorate_id;
  }

  MotherStatusDataController emsc =
      Get.put(MotherStatusDataController());

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
            height: 520,
            child: Form(
              key: emsc.editMotherStatusDataFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: Text(
                      'تعديل بيانات الأم',
                      textAlign: TextAlign.center,
                      style: MyTextStyles.font18PrimaryBold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الاســم',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            controller: nameCon,
                            validator: emsc.nameValidator,
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
                            controller: identityNumberCon,
                            validator: emsc.identityNumberValidator,
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
                            controller: phoneCon,
                            validator: emsc.phoneNumberValidator,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'تاريخ الميلاد',
                            style: MyTextStyles.font14BlackBold,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: myTextField(
                              validator: emsc.birthDateValidator,
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
                                      emsc.birthDateController.text =
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
                        controller: villageCon,
                        validator: emsc.villageValidator,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (emsc.isUpdateLoading.value) {
                          return myLoadingIndicator();
                        } else {
                          return myButton(
                              width: 150,
                              onPressed: emsc.isUpdateLoading.value
                                  ? null
                                  : () {
                                      if (emsc
                                          .editMotherStatusDataFormKey.currentState!
                                          .validate()) {
                                        emsc.updateMotherStatusData(
                                            widget.motherData.id,
                                            nameCon.text,
                                            phoneCon.text,
                                            identityNumberCon.text,
                                            birthDateCon.text,
                                            sdc.selectedCityId.value!,
                                            sdc.selectedDirectorateId.value!,
                                            villageCon.text);
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
                            emsc.clearTextFields();
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
        ),
      ),
    );
  }
}
