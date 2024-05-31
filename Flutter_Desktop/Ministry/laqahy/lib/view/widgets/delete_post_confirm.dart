import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/create_posts_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class DeletePostConfirm extends StatelessWidget {
  DeletePostConfirm({
    super.key,
    required this.postId,
  });

  int postId;

  @override
  Widget build(BuildContext context) {
    print(postId);
    CreatePostsController cpc = Get.put(CreatePostsController());

    return AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          padding: EdgeInsetsDirectional.all(10),
          height: 360,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/confirm_image.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  ' هل أنت متأكد من عملية حذف',
                  style: MyTextStyles.font18BlackBold,
                ),
              ),
              Container(
                child: Text(
                  'هذا الإعـلان؟',
                  style: MyTextStyles.font18BlackBold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return cpc.isDeletePostsLoading.value
                        ? myLoadingIndicator()
                        : myButton(
                            backgroundColor: MyColors.redColor,
                            onPressed: cpc.isDeletePostsLoading.value
                                ? null
                                : () {
                                    cpc.deletePost(
                                      postId,
                                    );
                                  },
                            text: 'حـــــذف',
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
                    },
                    text: 'الغـــاء اللأمــر',
                    textStyle: MyTextStyles.font16WhiteBold,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
