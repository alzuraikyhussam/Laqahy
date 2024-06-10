import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/screens/login.dart';
import 'package:laqahy/view/screens/reset_password.dart';


import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class createnewpassword extends StatefulWidget {
  const createnewpassword ({super.key});

  @override
  State<createnewpassword> createState() =>
      _ResetPasswordVerificationState();
}

class _ResetPasswordVerificationState extends State<createnewpassword> {
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
                    'انشاء كلمة مرور جديده',
                    style: MyTextStyles.font18BlackBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'انشئ كلمة مرور جديدة لحسابك',
                    style: MyTextStyles.font16GreyMedium,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                 myTextField(
                        labelText: 'كلمة المرور',
                        prefixIcon: Icons.password_outlined,
                        suffixIcon: Icons.visibility_off_outlined,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (p0) {},
                      ),
                  SizedBox(
                    height: 15,
                  ),
                  myTextField(
                        labelText: ' تاكيد كلمه المرور',
                        prefixIcon: Icons.password_outlined,
                        suffixIcon: Icons.visibility_off_outlined,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (p0) {},
                      ),
                      SizedBox(
                    height: 15,
                  ),
                  myButton(
                    onPressed: () {
                      myAwesomeDialog(
                        context: context,
                        title: 'تمت العملية بنجاح ',
                        desc: 'تم اعادة تعين كلمه المرور الخاصه بحسابك.',
                        showBtnCancel: false,
                        btnOkText: 'تسجيل دخول',
                        btnOkOnPress: () {
                          // Get.back();
                        },
                      );
                     
                    },
                    width: width,
                    text: '  انشاء كلمه مرور جديدة ',
                    textStyle: MyTextStyles.font14WhiteBold,
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