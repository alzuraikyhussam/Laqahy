import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateNewPass extends StatefulWidget {
  const CreateNewPass({super.key});

  @override
  State<CreateNewPass> createState() => _CreateNewPassState();
}

class _CreateNewPassState extends State<CreateNewPass> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar(
        text: '',
        showBackButton: true,
        onTap: () {
          Get.back();
        },
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'انشاء كلمة مرور جديدة',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'أنشئ كلمة مرور جديدة لحسابك',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    labelText: 'أدخل كلمة المرور',
                    prefixIcon: Icons.lock_outline_sharp,
                    suffixIcon: Icons.visibility,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: Icons.lock_outline_sharp,
                    suffixIcon: Icons.visibility,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  myButton(
                    onPressed: () {
                      myAwesomeDialog(
                        context: context,
                        title: 'تم الإرسـال بنجـاح',
                        desc: 'لقد تم إرسال كود التحقق الى رقم جوالك.',
                        showBtnCancel: false,
                        btnOkText: 'موافق',
                        btnOkOnPress: () {
                          // Get.back();
                        },
                      );
                      Get.off(ResetPasswordVerification());
                    },
                    width: width,
                    text: 'انشاء كلمة مرور جديدة',
                    textStyle: MyTextStyles.font16WhiteBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
