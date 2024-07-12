import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/report_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class CreateCentersReportDialog extends StatefulWidget {
  const CreateCentersReportDialog({super.key});

  @override
  State<CreateCentersReportDialog> createState() =>
      _CreateCentersReportDialogState();
}

class _CreateCentersReportDialogState extends State<CreateCentersReportDialog> {
  ReportController rc = Get.put(ReportController());
  StaticDataController sdc = Get.find<StaticDataController>();

  @override
  void initState() {
    rc.fetchCentersReport();
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
