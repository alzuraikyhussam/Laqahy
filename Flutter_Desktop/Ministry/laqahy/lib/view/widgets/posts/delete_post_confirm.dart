import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/post_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class DeletePostConfirm extends StatelessWidget {
  DeletePostConfirm({
    super.key,
    required this.postId,
  });

  int postId;

  @override
  Widget build(BuildContext context) {
    PostController cpc = Get.put(PostController());

    return AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 320,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Lottie.asset(
                  'assets/images/delete-confirm.json',
                  alignment: Alignment.center,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return cpc.isDeletePostsLoading.value
                        ? myLoadingIndicator()
                        : Expanded(
                            child: myButton(
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
                            ),
                          );
                  }),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: myButton(
                      backgroundColor: MyColors.greyColor,
                      onPressed: () {
                        Get.back();
                      },
                      text: 'إلغـــاء الأمـــر',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
