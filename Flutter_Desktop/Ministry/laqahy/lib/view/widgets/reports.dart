import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/reports_controller.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  ReportsController rc = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset('assets/images/vaccines-background.png'),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: rc.reportsCardItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 220,
          ),
          itemBuilder: (context, index) {
            return myReportsCards(
              imageName: rc.reportsCardItems[index].imageName,
              title: rc.reportsCardItems[index].title,
              context: context,
            );
          },
        ),
      ],
    );
  }
}
