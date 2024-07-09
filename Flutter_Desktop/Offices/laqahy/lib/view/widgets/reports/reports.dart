import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  ReportController rc = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 10,
          child: SvgPicture.asset(
            'assets/images/reports-image.svg',
            width: 350,
          ),
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
              onPressed: () {
                rc.clearTextFields();
                myShowDialog(
                  context: context,
                  widgetName: rc.reportsCardItems[index].onPressed,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
