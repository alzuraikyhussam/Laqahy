import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateOfficesReportDialog extends StatefulWidget {
  const CreateOfficesReportDialog({super.key});

  @override
  State<CreateOfficesReportDialog> createState() =>
      _CreateOfficesReportDialogState();
}

class _CreateOfficesReportDialogState extends State<CreateOfficesReportDialog> {
  ReportController rc = Get.put(ReportController());

  @override
  void initState() {
    rc.fetchOfficesReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      alignment: AlignmentDirectional.center,
      content: Center(
        child: myLoadingIndicator(height: 70),
      ),
    );
  }
}
