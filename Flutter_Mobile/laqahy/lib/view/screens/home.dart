import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'تسجيل دخول'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              myButton(
                onPressed: () {},
                text: 'مرحبا بكم',
                textStyle: MyTextStyles.font14WhiteBold,
              ),
              const SizedBox(
                height: 10,
              ),
              // myTextField(
              //   labelText: 'رقم الهـــاتف',
              //   keyboardType: TextInputType.text,
              //   onChanged: (String) {},
              // ),
              const SizedBox(
                height: 10,
              ),
              // myMiniButton(
              //   onPressed: () {},
              // ),
              const SizedBox(
                height: 10,
              ),
              myTextButton(
                text: 'نسيت كلمة المرور!',
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              myCircleAvatar(icon: Icons.person),
              const SizedBox(
                height: 10,
              ),
              myListTile(
                onTap: () {},
                icon: Icons.person,
                title: 'الوضع المظلم',
                subtitle: 'قم بالتبديل الى لوضع المظلم.',
              ),
              myListTile(
                onTap: () {},
                icon: Icons.person,
                title: 'الوضع المظلم',
                subtitle: 'قم بالتبديل الى لوضع المظلم.',
              ),
              const SizedBox(
                height: 10,
              ),
              myButton(
                onPressed: () {
                  myAwesomeDialog(
                    context: context,
                    btnOkOnPress: () {
                      Get.back();
                    },
                    title: 'تمت العملية بنجاح',
                    desc: 'تم تنفيذ عملية اضافة الموظف بنجاح.',
                  );
                },
                text: 'اضغط هنا',
                textStyle: MyTextStyles.font14WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
