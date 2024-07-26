import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/visits/mother_visit/delete_mother_statement.dart';

class MotherVisitRowSource extends DataTableSource {
  var myData;
  final count;
  MotherVisitRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final motherStatementData = myData[index];
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
              motherStatementData.dosage_level ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              motherStatementData.dosage_type ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              motherStatementData.healthy_center,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              motherStatementData.userName,
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
                  .format(motherStatementData.date_taking_dose),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy').format(motherStatementData.return_date),
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
                    widgetName: DeleteMotherStatement(
                      id: motherStatementData.id,
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

// class MotherVisitRowSource extends DataTableSource {
//   var myData;
//   final count;
//   MotherVisitRowSource({
//     required this.myData,
//     required this.count,
//   });

//   @override
//   DataRow? getRow(int index) {
//     if (index < rowCount) {
//       return recentFileDataRow(myData![index]);
//     } else
//       return null;
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => count;

//   @override
//   int get selectedRowCount => 0;
// }

// DataRow recentFileDataRow(var data) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Container(
//           alignment: AlignmentDirectional.center,
//           child: Text(
//             data.dosageType.toString(),
//             textAlign: TextAlign.center,
//             style: MyTextStyles.font14BlackMedium,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           alignment: AlignmentDirectional.center,
//           child: Text(
//             data.healthCenter,
//             textAlign: TextAlign.center,
//             style: MyTextStyles.font14BlackMedium,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           alignment: AlignmentDirectional.center,
//           child: Text(
//             data.fullUserName,
//             textAlign: TextAlign.center,
//             style: MyTextStyles.font14BlackMedium,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           alignment: AlignmentDirectional.center,
//           child: Text(
//             data.dosageDate.toString(),
//             textAlign: TextAlign.center,
//             style: MyTextStyles.font14BlackMedium,
//           ),
//         ),
//       ),
//       DataCell(
//         Container(
//           alignment: AlignmentDirectional.center,
//           child: Text(
//             data.returnDate.toString(),
//             textAlign: TextAlign.center,
//             style: MyTextStyles.font14BlackMedium,
//           ),
//         ),
//       ),
//       DataCell(
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             myIconButton(
//               icon: Icons.edit_rounded,
//               onTap: () {},
//               gradientColors: [
//                 MyColors.primaryColor,
//                 MyColors.secondaryColor,
//               ],
//               padding: EdgeInsets.all(8),
//               iconSize: 22,
//             ),
//             myIconButton(
//               icon: Icons.delete,
//               onTap: () {},
//               gradientColors: [
//                 MyColors.redColor,
//                 MyColors.redColor,
//               ],
//               padding: EdgeInsets.all(8),
//               iconSize: 22,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
