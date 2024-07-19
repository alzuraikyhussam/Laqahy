import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        text: 'حول التطبيق',
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/screen-background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    'assets/images/app-logo-info-system.png',
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'مرحبًا بكم في تطبيق لقاحي، التطبيق الذي يهدف إلى تسهيل عملية تتبع وإدارة جدول التطعيمات لك ولعائلتك بطريقة بسيطة وفعالة. \nيعتبر لقاحي مصدرًا موثوقًا للمعلومات والتذكيرات حول اللقاحات الضرورية لحماية صحتك وصحة أفراد عائلتك. من خلال تطبيق لقاحي، يمكنك: تتبع مواعيد اللقاحات لكل فرد في الأسرة والحصول على تذكيرات دورية للتأكد من عدم تفويت أي جرعة. الوصول إلى معلومات شاملة حول كل لقاح، بما في ذلك فوائده وآثاره الجانبية المحتملة. توفير بيانات موثوقة ومحدثة حول جدول التطعيمات الموصى بها للأطفال والبالغين. \nباستخدام تطبيق لقاحي، نسعى إلى تحسين جودة الرعاية الصحية للمجتمع والمساهمة في الحد من انتشار الأمراض المعدية. انضم إلينا اليوم وانطلق في رحلة الصحة والوقاية.',
                  style: TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 14,
                    height: 2,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/app-logo-info-system-sm.png',
                  width: 200,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Version 1.0.0',
                  style: MyTextStyles.font14PrimaryBold,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
