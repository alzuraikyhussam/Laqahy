import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:laqahy/core/utils/pdf/pdf_widgets/pdf_widgets.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:share_plus/share_plus.dart';

class MotherStatusDataPdfGenerator {
  StaticDataController sdc = Get.find<StaticDataController>();
  final List data;
  String? reportName;

  MotherStatusDataPdfGenerator({
    required this.data,
    required this.reportName,
  });

  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    final PDFWidgets pdfWidgets = PDFWidgets();
    final pageSize =
        PdfPageFormat(7.25 * PdfPageFormat.cm, 13 * PdfPageFormat.cm);

    await pdfWidgets.init();

    // Load font
    final ttf =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Times-New-Roman.ttf'));
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/splash-logo.png'))
          .buffer
          .asUint8List(),
    );

    pw.TextStyle headerTextStyle = pw.TextStyle(
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
      font: ttf,
    );

    // Build content of the PDF document
    pw.Widget buildContent(pw.Context context) {
      return pw.Container(
        padding: pw.EdgeInsets.all(7),
        width: Get.width,
        height: Get.height,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
              level: 0,
              padding: const pw.EdgeInsetsDirectional.only(
                bottom: 15,
              ),
              child: pw.Center(
                child: pw.Container(
                  width: Get.width,
                  child: pw.Image(
                    logo,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              width: Get.width,
              padding: const pw.EdgeInsets.all(7),
              // color: PdfColors.grey200,
              alignment: pw.Alignment.center,
              child: pw.Text(
                reportName ?? '',
                textAlign: pw.TextAlign.center,
                style: headerTextStyle,
              ),
            ),
            pw.SizedBox(height: 15),
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('اسم الام : '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.mother_name}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('رقم الهاتف : '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.mother_phone}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('تاريخ الميلاد : '),
                    pw.SizedBox(width: 3),
                    pw.Text(
                        '${DateFormat('yyyy-MM-dd').format(data.first.mother_birthDate)}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('الــمدينة : '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.cityName}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('المديرية: '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.directorateName}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('اسم المستخدم : '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.mother_identity_num}')
                  ],
                ),
                pw.SizedBox(height: 7),
                pw.Row(
                  children: [
                    pw.Text('كلمة المرور : '),
                    pw.SizedBox(width: 3),
                    pw.Text('${data.first.mother_password}')
                  ],
                ),
                pw.SizedBox(height: 50),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'تم طباعة هذا التقرير بواسطة نظام لقاحي',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('#269D89'),
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // buildFooter(pw.Context context) {
    //   return
    // }

    // Add page to the PDF document
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(
            base: ttf,
            bold: ttf,
            italic: ttf,
            boldItalic: ttf,
          ),
          pageFormat: pageSize.copyWith(
            marginLeft: 7,
            marginRight: 7,
            marginTop: 7,
            marginBottom: 7,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        build: (pw.Context context) {
          return buildContent(context);
        },
        // footer: (context) {
        //   return buildFooter(context);
        // },
      ),
    );

    Future<void> shareFile({required File file, required String name}) async {
      try {
        // Share PDF
        await Share.shareXFiles([XFile(file.path)], text: name);
      } catch (e) {
        Get.back();
        ApiExceptionWidgets().mySharePdfFailureAlert();
      }
    }

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
      } catch (e) {
        Get.back();
        ApiExceptionWidgets().myGeneratePdfFailureAlert();
      }
    }

    await pdfWidgets.savePdfDocument(
      fileName: 'MotherStatusData.pdf',
      pdf: pdf,
    );

    // void printerPdf() async
    // {
    //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => await pdf.save());
    // }
  }
}
