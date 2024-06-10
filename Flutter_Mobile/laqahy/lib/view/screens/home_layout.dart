import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/homepage_controller.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeLayout extends StatelessWidget {
  HomePageController PageController = Get.put(HomePageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(text: 'تسجيل دخول'),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: PageController.currentIndex.value,
          onTap: (value) {
            PageController.currentIndex.value = value;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper), label: 'ألاخبار'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: 'الملف الشخصي'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
             
               
             
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
