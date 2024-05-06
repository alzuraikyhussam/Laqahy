import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/add_user_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

import 'edit_post_successfully.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  AddUserController aec = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'تــعــديــل الإعـــلان',
                textAlign: TextAlign.center,
                style: MyTextStyles.font18PrimaryBold,
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عنـوان المنشـور',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myTextField(
                      hintText: 'عنوان المنشور',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      width: 500,
                      maxLength: 150,
                      prefixIcon: Icons.label_outlined,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'صـورة المنشـور',
                      style: MyTextStyles.font16BlackBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myTextField(
                      hintText: 'اختر صورة المنشور',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      readOnly: true,
                      width: 200,
                      prefixIcon: Icons.photo_size_select_actual_outlined,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'وصـف المنشـور',
                  style: MyTextStyles.font16BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  hintText: 'وصف المنشور',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  width: 700,
                  maxLines: 5,
                  prefixIcon: Icons.description_outlined,
                ),
              ],
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
                              widgetName: const EditPostSuccessfully());
                        },
                        text: 'تـــعديــل',
                        textStyle: MyTextStyles.font16WhiteBold),
                  ),
                  Container(
                    width: 140,
                    child: myButton(
                      backgroundColor: MyColors.greyColor,
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
