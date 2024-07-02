import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class MotherVisitRowSource extends DataTableSource {
  var myData;
  final count;
  MotherVisitRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(var data) {
  return DataRow(
    cells: [
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            data.dosageType.toString(),
            textAlign: TextAlign.center,
            style: MyTextStyles.font14BlackMedium,
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            data.healthCenter,
            textAlign: TextAlign.center,
            style: MyTextStyles.font14BlackMedium,
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            data.fullUserName,
            textAlign: TextAlign.center,
            style: MyTextStyles.font14BlackMedium,
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            data.dosageDate.toString(),
            textAlign: TextAlign.center,
            style: MyTextStyles.font14BlackMedium,
          ),
        ),
      ),
      DataCell(
        Container(
          alignment: AlignmentDirectional.center,
          child: Text(
            data.returnDate.toString(),
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
              onTap: () {},
              gradientColors: [
                MyColors.primaryColor,
                MyColors.secondaryColor,
              ],
              padding: EdgeInsets.all(8),
              iconSize: 22,
            ),
            myIconButton(
              icon: Icons.delete,
              onTap: () {},
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
