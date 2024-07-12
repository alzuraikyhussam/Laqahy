import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateVaccinesReportDialog extends StatefulWidget {
  const CreateVaccinesReportDialog({super.key});

  @override
  State<CreateVaccinesReportDialog> createState() =>
      _CreateVaccinesReportDialogState();
}

class _CreateVaccinesReportDialogState
    extends State<CreateVaccinesReportDialog> {
  ReportController rc = Get.put(ReportController());

  @override
  void initState() {
    rc.fetchVaccinesQtyReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      content: SizedBox(
        height: 100,
        child: Center(
          child: myLoadingIndicator(height: 60),
        ),
      ),
    );
  }
}
