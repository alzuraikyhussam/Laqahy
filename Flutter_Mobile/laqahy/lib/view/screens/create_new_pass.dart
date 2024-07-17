import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/reset_password_verification.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'إنشاء كلمة مرور جديدة',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'أنشئ كلمة مرور جديدة لحسابك',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    labelText: 'أدخل كلمة المرور',
                    prefixIcon: Icons.lock_outline_sharp,
                    suffixIcon: Icons.visibility,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myTextField(
                    labelText: 'تأكيد كلمة المرور',
                    prefixIcon: Icons.lock_outline_sharp,
                    suffixIcon: Icons.visibility,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myButton(
                    onPressed: () {
                      // Get.off(const ResetPasswordVerification());
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
