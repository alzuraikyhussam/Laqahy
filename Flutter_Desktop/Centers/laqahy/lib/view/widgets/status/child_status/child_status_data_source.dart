import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/status/child_status/edit_child_status_data.dart';

class ChildrenStatusDataSource extends DataTableSource {
  var myData;
  final count;
  ChildrenStatusDataSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final child = myData[index];
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
              child.child_data_name ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              child.motherName,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              child.child_data_birthplace,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy').format(child.child_data_birthDate),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              child.genderType,
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
                    widgetName: EditChildStatusData(
                      childData: myData[index],
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
