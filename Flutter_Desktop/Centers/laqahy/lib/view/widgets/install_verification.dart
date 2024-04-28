import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/create_admin_account.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class InstallVerification extends StatefulWidget {
  const InstallVerification({super.key});

  @override
  State<InstallVerification> createState() => _InstallVerificationState();
}

class _InstallVerificationState extends State<InstallVerification> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        height: 280,
        width: 400,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myAppBarLogo(
                    width: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Text(
              'أدخــل رمــز التثبيـت',
              style: MyTextStyles.font18PrimaryBold,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: Text(
                'الرجاء إدخال رمز التثبيت المرسل من الوزارة من أجل إكمال عملية التثبيت.',
                style: MyTextStyles.font16BlackMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            myTextField(
              width: 300,
              prefixIcon: Icons.password,
              obscureText: true,
              suffixIcon: Icons.visibility_off_outlined,
              hintText: 'أدخـــل رمــز التثبيـت',
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              onChanged: (value) {},
            ),
            SizedBox(
              height: 5,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       child: Text(
            //         'لم يصل الكود؟',
            //         style: MyTextStyles.font16GreyMedium,
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //     myTextButton(
            //       text: 'إعــادة إرســال',
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      actions: [
        myButton(
          onPressed: () {
            // Get.offAll(HomeLayout());
            Get.off(CreateAdminAccount());
          },
          width: 150,
          text: 'مــوافــق',
          textStyle: MyTextStyles.font16WhiteBold,
        ),
        myButton(
          width: 150,
          onPressed: () {
            Get.back();
          },
          text: 'إلـغــاء الأمـــر',
          textStyle: MyTextStyles.font16WhiteBold,
          backgroundColor: MyColors.greyColor,
        ),
      ],
    );
  }
}
