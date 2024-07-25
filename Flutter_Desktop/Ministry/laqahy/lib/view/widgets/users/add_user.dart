import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/create_account_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/users/add_user_successfully.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  UserController uc = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: MyColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 520,
        child: Form(
          key: uc.createUserAccountFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'اضافة مستخدم جديد',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الاسم الرباعي',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 300,
                        child: myTextField(
                            controller: uc.nameController,
                            validator: uc.nameValidator,
                            prefixIcon: Icons.person_outline_sharp,
                            hintText: 'الاسم الرباعي',
                            keyboardType: TextInputType.text,
                            onChanged: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم الجوال',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 200,
                        child: myTextField(
                          controller: uc.phoneNumberController,
                          validator: uc.phoneNumberValidator,
                          prefixIcon: Icons.phone_outlined,
                          hintText: 'رقم الجوال',
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الجنس',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      SizedBox(
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
              Container(
                // width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اسم المستخدم',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: uc.userNameController,
                              validator: uc.userNameValidator,
                              width: 230,
                              prefixIcon: Icons.person_pin_outlined,
                              hintText: 'اسم المستخدم',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'كلمة المرور',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: uc.passwordController,
                              validator: uc.passwordValidator,
                              width: 230,
                              prefixIcon: Icons.password_outlined,
                              hintText: 'كلمة المرور',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تحديد الصلاحية',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Constants().permissionsDropdownMenu(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            validator: uc.birthDateValidator,
                            controller: uc.birthDateController,
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
                                    uc.birthDateController.text =
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
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العنوان',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: uc.addressController,
                              validator: uc.addressValidator,
                              width: 300,
                              prefixIcon: Icons.location_on_outlined,
                              hintText: 'العنوان',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return uc.isAddLoading.value
                        ? myLoadingIndicator(width: 150)
                        : myButton(
                            width: 150,
                            onPressed: uc.isAddLoading.value
                                ? null
                                : () {
                                    if (uc
                                        .createUserAccountFormKey.currentState!
                                        .validate()) {
                                      uc.addUser();
                                      // Get.back();
                                    }
                                    // myShowDialog(
                                    //     context: context,
                                    //     widgetName:
                                    //         const AddUserSuccessfully());
                                  },
                            text: 'اضــافة',
                            textStyle: MyTextStyles.font16WhiteBold);
                  }),
                  SizedBox(
                    width: 20,
                  ),
                  myButton(
                      width: 150,
                      backgroundColor: MyColors.greyColor,
                      onPressed: () {
                        Get.back();
                      },
                      text: 'إلغـــاء الأمـــر',
                      textStyle: MyTextStyles.font16WhiteBold),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
