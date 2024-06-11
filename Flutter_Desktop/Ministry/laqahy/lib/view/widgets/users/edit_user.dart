import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class EditUser extends StatefulWidget {
  EditUser({super.key, required this.data});

  var data;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController userNameController;
  TextEditingController passwordController = TextEditingController();
  late TextEditingController phoneController;

  TextEditingController birthdateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sdc.selectedGenderId.value = widget.data.userGenderId;
    sdc.selectedPermissionId.value = widget.data.userPermissionId;
    nameController = TextEditingController(text: widget.data.name);
    addressController = TextEditingController(text: widget.data.address);
    userNameController = TextEditingController(text: widget.data.username);
    // passwordController = TextEditingController(text: widget.data.password);
    phoneController = TextEditingController(text: widget.data.phone);
    birthdateController.text =
        DateFormat('MMM d, yyyy').format(widget.data.birthDate);
    ;
  }

  UserController uc = Get.put(UserController());
  StaticDataController sdc = Get.put(StaticDataController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      contentPadding: EdgeInsets.all(20),
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
          key: uc.editUserAccountFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'تعديل مستخدم',
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
                            controller: nameController,
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
                        child: myTextField(
                          width: 200,
                          controller: phoneController,
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
                        'الجنس ',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اسم المستخدم ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: userNameController,
                              validator: uc.userNameValidator,
                              width: 230,
                              prefixIcon: Icons.person_pin_outlined,
                              hintText: 'اسم المستخدم',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'كلمة المرور ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: passwordController,
                              validator: uc.passwordValidator,
                              width: 230,
                              prefixIcon: Icons.password_outlined,
                              hintText: 'أدخل كلمة مرور جديدة',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    SizedBox(
                      width: widget.data == sdc.storageService.getAdminId()
                          ? 0
                          : 20,
                    ),
                    widget.data == sdc.storageService.getAdminId()
                        ? Column(
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
                          )
                        : SizedBox()
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
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                            validator: uc.birthdateValidator,
                            controller: birthdateController,
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
                                    birthdateController.text =
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
                              controller: addressController,
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
                    return uc.isUpdateLoading.value
                        ? myLoadingIndicator()
                        : myButton(
                            width: 150,
                            onPressed: uc.isUpdateLoading.value
                                ? null
                                : () {
                                    if (uc.editUserAccountFormKey.currentState!
                                        .validate()) {
                                      uc.updateUser(
                                        widget.data.id,
                                        nameController.text,
                                        addressController.text,
                                        userNameController.text,
                                        passwordController.text,
                                        sdc.selectedPermissionId.value,
                                        phoneController.text,
                                        sdc.selectedGenderId.value,
                                        birthdateController.text,
                                      );
                                    }
                                    // myShowDialog(
                                    //     context: context,
                                    //     widgetName:
                                    //         const AddUserSuccessfully());
                                  },
                            text: 'تعـــديل',
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
                      text: 'الغـــاء اللأمــر',
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
