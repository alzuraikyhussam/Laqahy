import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/mother_status_data_controller.dart';
// import 'package:laqahy/controllers/mother_visit_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    MotherStatusDataController mc = Get.put(MotherStatusDataController());
    return Form(
      key: mc.createMotherStatusDataFormKey,
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
                    controller: mc.nameController,
                    validator: mc.nameValidator,
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
                    controller: mc.identityNumberController,
                    validator: mc.identityNumberValidator,
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
                    controller: mc.phoneNumberController,
                    validator: mc.phoneNumberValidator,
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
                      validator: mc.birthDateValidator,
                      controller: mc.birthDateController,
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
                              mc.birthDateController.text =
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
                'الــعزلـة',
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
                hintText: 'اســم العزلة',
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
              });
            },
            onChanged: (selected) {
              setState(() {
                isChecked = selected;
              });
            },
            value: isChecked,
            text: 'هـل لـديـك طـفـل؟',
          ),
          const SizedBox(
            height: 25,
          ),
          Obx(() {
            return mc.isAddLoading.value
                ? myLoadingIndicator()
                : myButton(
                    width: 150,
                    onPressed: mc.isAddLoading.value
                        ? null
                        : () {
                            if (mc
                                .createMotherStatusDataFormKey.currentState!
                                .validate()) {
                              mc.addMotherStatusData();
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
