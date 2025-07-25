import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/child_visit_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class DeleteChildStatement extends StatelessWidget {
  DeleteChildStatement({super.key, required this.id});

  int id;

  @override
  Widget build(BuildContext context) {
    ChildVisitController cvc = Get.put(ChildVisitController());
    // print(userId);
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
                      'هذه البيانات؟',
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
                  return cvc.isDeleteLoading.value
                      ? myLoadingIndicator()
                      : Expanded(
                          child: myButton(
                            backgroundColor: MyColors.redColor,
                            onPressed: cvc.isDeleteLoading.value
                                ? null
                                : () {
                                    cvc.deleteChildStatement(
                                      id,
                                    );
                                  },
                            text: 'حـــــذف',
                            textStyle: MyTextStyles.font16WhiteBold,
                          ),
                        );
                }),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: myButton(
                    backgroundColor: MyColors.greyColor,
                    onPressed: () {
                      Get.back();
                    },
                    text: 'الغـــاء الأمــــر',
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
