import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/visits/child_visit/delete_child_statement.dart';

class ChildVisitRowSource extends DataTableSource {
  var myData;
  final count;
  ChildVisitRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final childStatementData = myData[index];
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
              childStatementData.visitType ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              childStatementData.vaccineType,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              childStatementData.childDosageType,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy')
                  .format(childStatementData.dateTakingDose),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy').format(childStatementData.returnDate),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              childStatementData.userName,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              childStatementData.healthyCenterName,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Center(
            child: myIconButton(
              icon: Icons.delete,
              onTap: () {
                Constants().playErrorSound();
                myShowDialog(
                    context: Get.context!,
                    widgetName: DeleteChildStatement(
                      childId: childStatementData.childDataId,
                    ));
              },
              gradientColors: [
                MyColors.redColor,
                MyColors.redColor,
              ],
              padding: EdgeInsets.all(8),
              iconSize: 22,
            ),
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
