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

   TextEditingController birthdateController=TextEditingController();

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
    birthdateController.text = DateFormat('MMM d, yyyy').parse(widget.data.birthDate).toString();
  }

  UserController uc = Get.put(UserController());
  StaticDataController sdc = Get.put(StaticDataController());

  

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        height: 480,
        child: Form(
          key: uc.editUserAccountFormKey,
          child: Column(
            children: [
              Container(
                child: Text(
                  'تعديل موظف ',
                  textAlign: TextAlign.center,
                  style: MyTextStyles.font18PrimaryBold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  اسم الموظف',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 300,
                        child: myTextField(
                            controller: nameController,
                            validator: uc.nameValidator,
                            prefixIcon: Icons.person_outline_sharp,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (value) {}),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '      رقم الهاتف',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 3),
                        width: 200,
                        child: myTextField(
                          controller: phoneController,
                          validator: uc.phoneNumberValidator,
                          prefixIcon: Icons.phone_outlined,
                          hintText: '',
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  الجنس ',
                        style: MyTextStyles.font14BlackBold,
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
                          '  اسم المستخدم ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: userNameController,
                              validator: uc.userNameValidator,
                              width: 230,
                              prefixIcon: Icons.person,
                              hintText: '',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' كلمة مرور ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          child: myTextField(
                              controller: passwordController,
                              validator: uc.passwordValidator,
                              width: 230,
                              prefixIcon: Icons.lock,
                              hintText: '',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تحديد الصلاحية ',
                          style: MyTextStyles.font14BlackBold,
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
                          '   تاريخ الميلاد ',
                          style: MyTextStyles.font14BlackBold,
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
                              prefixIcon: Icons.location_city_outlined,
                              hintText: '',
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
              Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 130,
                        child: Obx(() {
                          return uc.isUpdateLoading.value
                              ? myLoadingIndicator()
                              : myButton(
                                  onPressed: uc.isUpdateLoading.value
                                      ? null
                                      : () {
                                          if (uc.editUserAccountFormKey
                                              .currentState!
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
                                            Get.back();
                                          }
                                          // myShowDialog(
                                          //     context: context,
                                          //     widgetName:
                                          //         const AddUserSuccessfully());
                                        },
                                  text: 'تعـــديل',
                                  textStyle: MyTextStyles.font16WhiteBold);
                        })),
                    Container(
                      width: 140,
                      child: myButton(
                          onPressed: () {
                            Get.back();
                          },
                          text: 'الغـــاء اللأمــر',
                          textStyle: MyTextStyles.font16WhiteBold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
