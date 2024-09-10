import 'dart:io';

import 'package:flutter/material.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PDFWidgets {
  late pw.Font ttf;
  late pw.MemoryImage basmallahImage;
  late pw.MemoryImage imageLogo;
  String? userName;
  String printFormattedDate =
      DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now());

  Future<void> init() async {
    StaticDataController sdc = Get.find<StaticDataController>();
    userName = sdc.userLoggedData.first.userName;

    ttf =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Times-New-Roman.ttf'));

    imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/yemen-logo.png'))
          .buffer
          .asUint8List(),
    );

    basmallahImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/basmalah.png'))
          .buffer
          .asUint8List(),
    );
  }

  // Define text styles
  pw.TextStyle get headerTextStyle => pw.TextStyle(
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
        font: ttf,
      );

  pw.TextStyle get bodyTextStyle => pw.TextStyle(
        fontSize: 14,
        font: ttf,
      );

  myShowSavedDialog(BuildContext context, File file) {
    // Constants().playSuccessSound();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: f.AlignmentDirectional.center,
          actionsAlignment: f.MainAxisAlignment.center,
          content: f.Container(
            padding: const f.EdgeInsetsDirectional.only(
              top: 20,
            ),
            height: 270,
            width: 350,
            child: f.Column(
              children: [
                f.Center(
                  child: f.Container(
                    height: 150,
                    // width: Get.width,
                    child: Lottie.asset(
                      'assets/images/success.json',
                      alignment: f.Alignment.center,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                f.Expanded(
                  child: f.Column(
                    mainAxisAlignment: f.MainAxisAlignment.center,
                    children: [
                      f.Text(
                        'تم حفظ التقرير بنجاح',
                        style: MyTextStyles.font18BlackBold,
                      ),
                      f.SizedBox(
                        height: 15,
                      ),
                      f.SizedBox(
                        width: 300,
                        child: f.Text(
                          'تم انشاء وحفظ التقرير في مجلد المستندات على جهازك',
                          maxLines: 3,
                          overflow: f.TextOverflow.ellipsis,
                          style: MyTextStyles.font16GreyMedium,
                          textAlign: f.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            myButton(
              onPressed: () async {
                Get.back();
                await OpenFile.open(file.path);
              },
              width: 150,
              backgroundColor: MyColors.primaryColor,
              text: 'مــوافق',
              textStyle: MyTextStyles.font16WhiteBold,
            ),
          ],
        );
      },
    );
  }

  // Build header of the PDF document
  pw.Widget buildHeader({required String centerData}) {
    return pw.Container(
      width: Get.width,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Container(
            alignment: pw.AlignmentDirectional.center,
            width: 180,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'الجمهورية اليمنية',
                  style: headerTextStyle,
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'وزارة الصحة والسكان',
                  style: headerTextStyle,
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'هاتف : $centerData',
                  style: headerTextStyle,
                ),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Image(
                  basmallahImage,
                  width: 80,
                  height: 80,
                ),
                pw.SizedBox(height: 10),
                pw.Image(
                  imageLogo,
                  width: 90,
                  height: 90,
                ),
              ],
            ),
          ),
          pw.Container(
            width: 180,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'طُبع بواسطة: ',
                      style: bodyTextStyle,
                    ),
                    pw.Container(
                      width: 120,
                      child: pw.Text(
                        '$userName',
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: bodyTextStyle,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      'في تاريخ: ',
                      style: bodyTextStyle,
                    ),
                    pw.Text(
                      '$printFormattedDateم',
                      style: bodyTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // pw.SizedBox();
  }

  pw.Widget buildTitle({
    required String title,
  }) {
    return pw.Container(
      width: Get.width,
      padding: const pw.EdgeInsets.all(10),
      // color: PdfColors.grey200,
      alignment: pw.Alignment.center,
      child: pw.Text(
        title,
        textAlign: pw.TextAlign.center,
        style: headerTextStyle,
      ),
    );
  }

  // Build signature of the PDF document
  documentSignature({
    required String? managerName,
  }) {
    return pw.Container(
      alignment: pw.AlignmentDirectional.centerEnd,
      width: Get.width,
      padding: pw.EdgeInsetsDirectional.only(end: 20),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'التوقيع',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            managerName ?? '',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
        ],
      ),
    );
  }

  // Build footer of the PDF document
  buildFooter(pw.Context context) {
    return pw.Container(
      width: Get.width,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            child: pw.Bullet(
              bulletSize: 1.5 * PdfPageFormat.mm,
              textAlign: pw.TextAlign.start,
              text: 'تم طباعة هذا التقرير بواسطة نظام لقاحي',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              'صفحة ${context.pageNumber} من ${context.pagesCount}',
              textAlign: pw.TextAlign.end,
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Save PDF
  savePdfDocument({required String fileName, required pdf}) async {
    // Generate file name based on current date and time
    String formattedDate =
        DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now());
    String name =
        '${formattedDate}_$fileName'; // Example: "19_06_2024_17:30_offices_report.pdf"

    try {
      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/$name');

      await file.writeAsBytes(await pdf.save());

      await shareFile(file: file, name: name);

      Get.back();

      myShowSavedDialog(Get.context!, file);
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().myGeneratePdfFailureAlert();
    }
  }

  Future<void> shareFile({required File file, required String name}) async {
    try {
      // Share PDF
      await Share.shareXFiles([XFile(file.path)], text: name);
    } catch (e) {
      Get.back();
      ApiExceptionWidgets().mySharePdfFailureAlert();
    }
  }
}
