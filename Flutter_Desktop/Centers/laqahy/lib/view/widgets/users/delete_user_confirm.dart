import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class DeleteUserConfirm extends StatelessWidget {
  DeleteUserConfirm({super.key, required this.userId});

  int userId;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController());
    print(userId);
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        // padding: EdgeInsetsDirectional.all(10),
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
                      'هذا المستخدم؟',
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
                  return uc.isDeleteLoading.value
                      ? myLoadingIndicator()
                      : Expanded(
                          child: myButton(
                            backgroundColor: MyColors.redColor,
                            onPressed: uc.isDeleteLoading.value
                                ? null
                                : () {
                                    uc.deleteUser(
                                      userId,
                                    );
                                  },
                            text: 'حـــــذف',
                            textStyle: MyTextStyles.font16WhiteBold,
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
                    text: 'إلغـــاء الأمــــر',
                    textStyle: MyTextStyles.font16WhiteBold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
