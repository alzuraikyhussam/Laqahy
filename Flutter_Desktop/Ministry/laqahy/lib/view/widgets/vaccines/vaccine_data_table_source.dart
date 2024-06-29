import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/vaccines/delete_vaccine_statement.dart';
import 'package:laqahy/view/widgets/vaccines/edit_vaccine_quantity.dart';

class VaccineRowSource extends DataTableSource {
  var myData;
  final count;
  VaccineRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final vaccine = myData[index];
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              vaccine.id.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              vaccine.vaccineType ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              vaccine.donorName,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              vaccine.quantity.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('dd-MM-yyyy').format(vaccine.date),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myIconButton(
                icon: Icons.edit_rounded,
                onTap: () {
                  myShowDialog(
                    context: Get.context!,
                    widgetName: EditVaccineQuantity(
                      data: myData[index],
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
                icon: Icons.delete,
                onTap: () {
                  Constants().playErrorSound();

                  myShowDialog(
                      context: Get.context!,
                      widgetName: DeleteVaccineStatement(
                        id: vaccine.id,
                      ));
                },
                gradientColors: [
                  MyColors.redColor,
                  MyColors.redColor,
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
