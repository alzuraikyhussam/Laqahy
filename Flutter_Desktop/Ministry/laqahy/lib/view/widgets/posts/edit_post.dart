import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqahy/controllers/post_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class EditPostDialog extends StatefulWidget {
  EditPostDialog({
    super.key,
    required this.postId,
    required this.title,
    required this.desc,
    required this.image,
  });

  int postId;
  String title;
  String desc;
  dynamic image;

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  PostController cpc = Get.put(PostController());

  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descController = TextEditingController(text: widget.desc);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cpc.updatePostFormKey,
      child: AlertDialog(
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
          padding: EdgeInsetsDirectional.all(20),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تــعــديــل بيــانات الإعـــلان',
                textAlign: TextAlign.center,
                style: MyTextStyles.font18PrimaryBold,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'عنـوان الإعــلان',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: titleController,
                        validator: cpc.titleValidator,
                        hintText: 'عنوان الإعــلان',
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        width: 500,
                        maxLength: 100,
                        prefixIcon: Icons.label_outlined,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'وصـف الإعــلان',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        hintText: 'وصف الإعــلان',
                        controller: descController,
                        validator: cpc.descValidator,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        width: 500,
                        maxLines: 5,
                        heightFactor: 4.8,
                        prefixIcon: Icons.description_outlined,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Obx(() {
                          return cpc.updatedImage.value == null
                              ? Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  cpc.updatedImage.value!,
                                  fit: BoxFit.cover,
                                );
                        }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      myButton(
                        onPressed: () async {
                          await cpc.pickImage(
                            ImageSource.gallery,
                            type: 'edit',
                          );
                        },
                        text: 'تغييـر الصـورة',
                        textStyle: MyTextStyles.font16WhiteBold,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return cpc.isUpdatePostsLoading.value
                        ? myLoadingIndicator()
                        : myButton(
                            onPressed: cpc.isUpdatePostsLoading.value
                                ? null
                                : () {
                                    if (cpc.updatePostFormKey.currentState!
                                        .validate()) {
                                      cpc.updatePost(
                                        widget.postId,
                                        titleController.text,
                                        descController.text,
                                      );
                                    }
                                  },
                            text: 'تـــعديــل',
                            textStyle: MyTextStyles.font16WhiteBold,
                            width: 130,
                          );
                  }),
                  SizedBox(
                    width: 15,
                  ),
                  myButton(
                    backgroundColor: MyColors.greyColor,
                    onPressed: () {
                      Get.back();
                      cpc.updatedImage.value = null;
                    },
                    text: 'الغـــاء اللأمــر',
                    textStyle: MyTextStyles.font16WhiteBold,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
