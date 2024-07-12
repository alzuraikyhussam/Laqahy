import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/utils/pdf/pdf_widgets/pdf_widgets.dart';
import 'package:laqahy/models/center_order_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrdersPdfGenerator {
  StaticDataController sdc = Get.find<StaticDataController>();
  final List<CenterOrder> data;
  String? managerName;
  String? reportName;

  int serialNum = 0;

  OrdersPdfGenerator({
    required this.data,
    required this.managerName,
    required this.reportName,
  });

  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    final PDFWidgets pdfWidgets = PDFWidgets();

    await pdfWidgets.init();

    // Load font
    final ttf =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Times-New-Roman.ttf'));

    final tableHeaderTextStyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
      font: ttf,
    );

    final tableBodyTextStyle = pw.TextStyle(
      fontSize: 12,
      font: ttf,
    );

    // Build content of the PDF document
    List<pw.Widget> buildContent(pw.Context context) {
      return [
        pw.Header(
          level: 0,
          padding: const pw.EdgeInsetsDirectional.only(
            bottom: 15,
          ),
          child: pdfWidgets.buildHeader(officeData: sdc.officeData),
        ),
        pdfWidgets.buildTitle(
          title: reportName ?? '',
        ),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          headers: [
            'تاريخ التسليم',
            'تاريخ الطلب',
            'حالة الطلب',
            'الكمية',
            'اسم اللقاح',
            'اسم المركز',
            'م',
          ],
          data: data
              .map(
                (data) => [
                  data.deliveryDate == null
                      ? ''
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(data.deliveryDate!),
                  data.orderDate == null
                      ? ''
                      : DateFormat('dd-MM-yyyy HH:mm').format(data.orderDate!),
                  data.orderStateName,
                  data.quantity,
                  data.vaccineType,
                  data.centerName,
                  // data.id,
                  serialNum += 1,
                ],
              )
              .toList(),
          headerStyle: tableHeaderTextStyle,
          cellStyle: tableBodyTextStyle,
          headerDecoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          cellHeight: 30,
          cellAlignment: pw.Alignment.center,
          cellDecoration: (index, data, rowNum) => rowNum % 2 == 0
              ? const pw.BoxDecoration(
                  color: PdfColors.grey100,
                )
              : const pw.BoxDecoration(
                  color: PdfColors.white,
                ),
          headerAlignment: pw.Alignment.center,
          border: const pw.TableBorder(
            top: pw.BorderSide(
              width: 0.5,
              color: PdfColors.black,
            ),
            bottom: pw.BorderSide(
              width: 0.5,
              color: PdfColors.black,
            ),
            left: pw.BorderSide(
              width: 0.5,
              color: PdfColors.black,
            ),
            right: pw.BorderSide(
              width: 0.5,
              color: PdfColors.black,
            ),
            horizontalInside: pw.BorderSide(
              width: 1,
              color: PdfColors.grey,
            ),
            verticalInside: pw.BorderSide(
              width: 1,
              color: PdfColors.grey,
            ),
          ),
        ),
        pw.SizedBox(height: 50),
        pdfWidgets.documentSignature(managerName: managerName),
      ];
    }

    // Add page to the PDF document
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(
            base: ttf,
            bold: ttf,
            italic: ttf,
            boldItalic: ttf,
          ),
          pageFormat: PdfPageFormat.a4.landscape.copyWith(
            marginLeft: 30,
            marginRight: 30,
            marginTop: 30,
            marginBottom: 30,
          ),
          textDirection: pw.TextDirection.rtl,

          // buildBackground: (context) {
          //   return pw.Container(
          //     decoration: pw.BoxDecoration(
          //       border: pw.Border.all(
          //         color: PdfColors.black,
          //         width: 2,
          //       ),
          //     ),
          //   );
          // },
        ),
        build: (pw.Context context) {
          return buildContent(context);
        },
        footer: (context) {
          return pdfWidgets.buildFooter(context);
        },
      ),
    );

    await pdfWidgets.savePdfDocument(
      fileName: 'orders_report.pdf',
      pdf: pdf,
    );
  }
}
