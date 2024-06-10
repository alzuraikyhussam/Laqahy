import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_account_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/users/add_user_successfully.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  CreateAccountController cac = Get.put(CreateAccountController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        height: 470,
        child: Column(
          children: [
            Container(
              child: Text(
                'اضافة موظف جديد ',
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
              width: 500,
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
                        margin: const EdgeInsets.only(left: 20, top: 3),
                        width: 230,
                        child: myTextField(
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
                        '  كلمة المرور ',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 230,
                        child: myTextField(
                            prefixIcon: Icons.lock,
                            hintText: '',
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {}),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   تاريخ الميلاد ',
                        style: MyTextStyles.font14BlackBold,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 3),
                        width: 230,
                        child: myTextField(
                            prefixIcon: Icons.date_range_outlined,
                            hintText: '',
                            keyboardType: TextInputType.datetime,
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
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 200,
                        child: myTextField(
                            prefixIcon: Icons.shield,
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
                    child: myButton(
                        onPressed: () {
                          myShowDialog(
                              context: context,
                              widgetName: const AddUserSuccessfully());
                        },
                        text: 'اضــافة',
                        textStyle: MyTextStyles.font16WhiteBold),
                  ),
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
    );
  }
}
