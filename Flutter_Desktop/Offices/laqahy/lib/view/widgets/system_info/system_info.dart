import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class SystemInfoScreen extends StatefulWidget {
  const SystemInfoScreen({super.key});

  @override
  State<SystemInfoScreen> createState() => _SystemInfoScreenState();
}

class _SystemInfoScreenState extends State<SystemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/system-info-image.svg',
          ),
        ),
        SingleChildScrollView(
          primary: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 30,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/app-logo-info-system.png',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تم تطوير نظام "لقاحي" ليكون مصدرًا موثوقًا وفعّالًا لتتبع وإدارة جدول التطعيمات للأفراد والعائلات. يعتمد التطبيق على مبادئ وتقنيات حديثة لضمان تقديم تجربة ممتازة للمستخدمين وضمان الحفاظ على صحتهم. فيما يلي بعض المعلومات حول نظام "لقاحي":',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'مبادئ التصميم:',
                      style: MyTextStyles.font18PrimaryBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'سهولة الاستخدام: تم تصميم واجهة المستخدم بشكل بسيط ومباشر لتسهيل عملية تتبع وإدارة جدول التطعيمات دون عناء.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'موثوقية البيانات: يتميز النظام بقاعدة بيانات موثوقة ومحدثة باستمرار لضمان دقة وسلامة المعلومات.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'توفير المعلومات: يوفر النظام معلومات شاملة وموثوقة حول جدول التطعيمات الموصى بها وفوائدها.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ميزات النظام:',
                      style: MyTextStyles.font18PrimaryBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'تتبع المواعيد: يتيح النظام تتبع مواعيد اللقاحات لكل فرد في الأسرة وتلقي تذكيرات دورية لضمان عدم تفويت أي جرعة.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'معلومات شاملة: يوفر النظام معلومات مفصلة حول كل لقاح، بما في ذلك فوائده والجرعات الموصى بها والآثار الجانبية المحتملة.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'تخصيص الإعدادات: يمكن للمستخدمين تخصيص إعدادات التذكيرات والإشعارات وفقًا لتفضيلاتهم الشخصية.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ما يميزنا:',
                      style: MyTextStyles.font18PrimaryBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'التزامن بين الأجهزة: يمكن للمستخدمين الوصول إلى بياناتهم وتتبع جدول التطعيمات من أي مكان باستخدام حسابهم عبر الأجهزة المتعددة.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'أمان البيانات: يتم حفظ جميع البيانات بشكل آمن وسري على الخوادم المشفرة لضمان خصوصية المستخدمين.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'نحن ملتزمون بتوفير تجربة مستخدم ممتازة وأداء عالي الجودة للمساهمة في رفاهية وصحة مستخدمينا. إذا كان لديكم أي استفسارات أو اقتراحات، فلا تترددوا في الاتصال بنا.',
                      style: MyTextStyles.font16BlackBold,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 600,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.greyColor.withOpacity(0.3),
                        blurRadius: 5,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        MyColors.primaryColor,
                        MyColors.secondaryColor,
                      ],
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'شكرًا لاختياركم تطبيق "لقاحي" لمتابعة ورعاية صحتكم وصحة أفراد عائلتكم.',
                    style: MyTextStyles.font16WhiteBold,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'assets/images/window-logo.png',
                  width: 250,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Version 1.0.0.1',
                  style: MyTextStyles.font16SecondaryBold,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
