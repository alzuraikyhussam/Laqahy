import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
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
    mouseCursor: MaterialStateMouseCursor.clickable,
    cells: [
      DataCell(Text(
        data.name ?? "Name",
        style: MyTextStyles.font14BlackMedium,
      )),
      DataCell(Text(
        data.phone.toString(),
        style: MyTextStyles.font14BlackMedium,
      )),
      DataCell(Text(
        data.age.toString(),
        style: MyTextStyles.font14BlackMedium,
      )),
    ],
  );
}
