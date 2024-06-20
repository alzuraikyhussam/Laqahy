import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/utils/pdf_widgets/pdf_widgets.dart';
import 'package:laqahy/models/center_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CentersPdfGenerator {
  StaticDataController sdc = Get.find<StaticDataController>();
  String? managerName;
  final List<HealthyCenter> centerData;

  CentersPdfGenerator({required this.centerData, required this.managerName}) {
    // userName = sdc.userLoggedData.first.userName!;
  }

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
          child:
              pdfWidgets.buildHeader(centerData: sdc.centerData.first.phone!),
        ),
        pdfWidgets.buildTitle(title: 'تقرير عن المراكز الصحية في ${centerData.first.officeName}'),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          headers: [
            'العنوان',
            'تاريخ الإنضمام',
            'المديرية',
            'المحافظة',
            'رقم الهاتف',
            'اسم المركز',
            'م',
          ],
          data: centerData
              .map(
                (center) => [
                  center.address,
                  DateFormat('dd-MM-yyyy HH:mm').format(center.createdAt!),
                  center.directorateName,
                  center.cityName,
                  center.phone,
                  center.name,
                  center.id,
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
          pageFormat: PdfPageFormat.a4.copyWith(
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

    pdfWidgets.savePdfDocument(
      fileName: 'centers_report.pdf',
      pdf: pdf,
    );
  }
}
