import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/mother_status/edit_mother_status_data.dart';

class MotherStatusDataSource extends DataTableSource {
  var myData;
  final count;
  MotherStatusDataSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final mother = myData[index];
    // StaticDataController sdc = Get.find<StaticDataController>();
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              // user.id.toString(),
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.mother_name ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.mother_phone,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.mother_identity_num,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy').format(mother.mother_birthDate),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.cityName,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.directorateName.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              mother.mother_village,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myIconButton(
                icon: Icons.edit_rounded,
                onTap: () async {
                  // int? adminId = await sdc.storageService.getAdminId();
                  myShowDialog(
                    context: Get.context!,
                    widgetName: EditMotherStatusData(
                      motherData: myData[index],
                    ),
                  );
                },
                gradientColors: [
                  MyColors.primaryColor,
                  MyColors.secondaryColor,
                ],
                padding: EdgeInsets.all(8),
                iconSize: 22,
              ),
              myIconButton(
                icon: Icons.print,
                onTap: () async {
                  // Constants().playErrorSound();
                  // final  List  data;
                  // print(myData[index]);
                  // MotherStatusDataPdfGenerator mpg =
                  //     MotherStatusDataPdfGenerator(
                  //         data: myData[index], reportName: 'بيانات الحالة');
                  // await mpg.generatePdf(Get.context!);
                },
                gradientColors: [
                  MyColors.greyColor,
                  MyColors.greyColor,
                ],
                padding: EdgeInsets.all(8),
                iconSize: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
