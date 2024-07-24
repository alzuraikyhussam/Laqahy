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

class MotherVisitDataPdfGenerator {
  StaticDataController sdc = Get.find<StaticDataController>();
  final List data;
  String? reportName;

  MotherVisitDataPdfGenerator({
    required this.data,
    required this.reportName,
  });

  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    final PDFWidgets pdfWidgets = PDFWidgets();
    final pageSize = PdfPageFormat(13 * PdfPageFormat.cm, 7 * PdfPageFormat.cm);

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
              padding: const pw.EdgeInsets.all(4),
              // color: PdfColors.grey200,
              alignment: pw.Alignment.center,
              child: pw.Row(
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        'الرقم التسلسلي  : ',
                        style: pw.TextStyle(fontSize: 10),
                      ),
                      pw.SizedBox(
                        width: 3,
                      ),
                      pw.Text(
                        '${data.first.id}',
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    width: 50,
                  ),
                  pw.Text(
                    reportName ?? '',
                    textAlign: pw.TextAlign.center,
                    style: headerTextStyle,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 15),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'اسم الحالة  : ',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(
                          width: 3,
                        ),
                        pw.Text(
                          '${data.first.motherName}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          'المركز الصحي  : ',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(
                          width: 3,
                        ),
                        pw.Text(
                          '${data.first.healthy_center}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          'العامل الصحي  : ',
                          style: pw.TextStyle(fontSize: 7),
                        ),
                        pw.SizedBox(
                          width: 3,
                        ),
                        pw.Text(
                          '${data.first.userName}',
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ],
                    ),
                  ],
                ),
                // pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'مرحلة الجرعة  : ',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(
                          width: 3,
                        ),
                        pw.Text(
                          '${data.first.dosage_level}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          'نوع الجرعة  : ',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(
                          width: 3,
                        ),
                        pw.Text(
                          '${data.first.dosage_type}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          "توقيع العامل الصحي",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ],
                    ),
                  ],
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

    Future<void> savePdfDocument(
        {required String fileName, required pdf}) async {
      // Generate file name based on current date and time
      String formattedDate =
          DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now());
      String name =
          '${formattedDate}_$fileName'; // Example: "19_06_2024_17:30_offices_report.pdf"

      try {
        final output = await getApplicationDocumentsDirectory();
        final file = File('${output.path}/$name');
        await file.writeAsBytes(await pdf.save());

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
