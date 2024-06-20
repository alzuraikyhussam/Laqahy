import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/models/office_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OfficePdfGenerator {
  final List<Office> offices;

  OfficePdfGenerator({required this.offices});

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    // Load the Tajawal font
    final tajawalFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Medium.ttf'));

    final headerTextStyle = pw.TextStyle(
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
      font: tajawalFont,
    );

    final bodyTextStyle = pw.TextStyle(
      fontSize: 11,
      font: tajawalFont,
    );

    final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/yemen-logo.png'))
          .buffer
          .asUint8List(),
    );

    // Generate file name based on current date and time
    String formattedDate =
        DateFormat('dd_MM_yyyy_HH_mm_ss').format(DateTime.now());
    String fileName =
        '${formattedDate}_offices_report.pdf'; // Example: "19_06_2024_17:30_offices_report.pdf"

    String PrintFormattedDate =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          textDirection: pw.TextDirection.rtl,
          // margin: pw.EdgeInsets.all(20),
          clip: true,
          orientation: pw.PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4,
          buildBackground: (context) {
            return pw.DecoratedBox(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  width: 2,
                  color: PdfColors.black,
                ),
              ),
            );
          },
        ),
        // textDirection: pw.TextDirection.rtl,
        // pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Header(
            padding: pw.EdgeInsetsDirectional.only(
              bottom: 30,
            ),
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: 150,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'الجمهورية اليمنية',
                        style: headerTextStyle,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'وزارة الصحة والسكان',
                        style: headerTextStyle,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'رقم الهاتف: 02354453',
                        style: headerTextStyle,
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                  child: pw.Image(
                    imageLogo,
                    width: 100,
                    height: 100,
                  ),
                ),
                pw.Container(
                  width: 150,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            'اسم الموظف: ',
                            style: bodyTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Container(
                            width: 150,
                            child: pw.Text(
                              'حسام خالد سعيد عdddddddddلي',
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
                            'تاريخ الطباعة: ',
                            style: bodyTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            PrintFormattedDate,
                            style: bodyTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            padding: pw.EdgeInsets.all(10),
            color: PdfColors.grey200,
            width: Get.width,
            alignment: pw.Alignment.center,
            child: pw.Text(
              'تقرير عن مكاتب الصحة والسكان',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14,
                font: tajawalFont,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Table.fromTextArray(
            // tableDirection: pw.TextDirection.rtl,
            headers: [
              'م',
              'اسم المكتب',
              'عدد المراكز',
              'رقم الهاتف',
              'العنوان',
              'تاريخ الانضمام',
            ],
            data: offices
                .map((office) => [
                      office.id,
                      office.name,
                      office.centersCount,
                      office.phone,
                      office.address,
                      office.createdAt,
                    ])
                .toList(),
            headerStyle: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              font: tajawalFont,
            ),
            cellStyle: pw.TextStyle(
              fontSize: 12,
              font: tajawalFont,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey400,
            ),
            headerAlignment: pw.Alignment.center,
            cellDecoration: (index, data, rowNum) => rowNum % 2 == 0
                ? const pw.BoxDecoration(
                    color: PdfColors.grey100,
                  )
                : const pw.BoxDecoration(
                    color: PdfColors.white,
                  ),
            cellHeight: 30,
            cellAlignment: pw.Alignment.center,
          ),
          // pw.SizedBox(height: 20),
          // pw.Paragraph(
          //   text: 'تم انشاء التقرير في تاريخ: ${DateTime.now().toString()}',
          //   style: pw.TextStyle(
          //     fontSize: 12,
          //     font: tajawalFont,
          //   ),
          // ),
        ],
        footer: (pw.Context context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'تم إنشاء التقرير  بواسطة نظام لقاحي',
                style: pw.TextStyle(
                  fontSize: 11,
                  // fontWeight: pw.FontWeight.bold,
                  font: tajawalFont,
                ),
              ),
              pw.Text(
                'صفحة ${context.pageNumber} من ${context.pagesCount}',
                style: pw.TextStyle(
                  fontSize: 10,
                  font: tajawalFont,
                ),
              ),
            ],
          );
        },
      ),
    );

    try {
// Save the PDF document
      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/$fileName');
      await file.writeAsBytes(await pdf.save());
      print("PDF saved at ${file.path}");
    } catch (e) {
      print(e);
    }

    // Share.shareFiles([file.path],text:'Offices Report');
  }
}
