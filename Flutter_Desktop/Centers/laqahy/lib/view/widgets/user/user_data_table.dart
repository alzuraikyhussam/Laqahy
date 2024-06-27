import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'delete_user_confirm.dart';
import 'edit_user.dart';


class UserRowSource extends DataTableSource {
  var myData;
  final count;
  UserRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) {
      return null;
    }

    final user = myData[index];
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.id.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.name ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.genderType,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              DateFormat('MMM d,yyyy').format(user.birthDate),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.permissionType,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.phone,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.username,
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              '********',
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              user.address,
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
                onTap: () {
                  myShowDialog(
                    context: Get.context!,
                    widgetName: EditUser(
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
                  // Constants().errorAudio();

                  myShowDialog(
                      context: Get.context!,
                      widgetName: DeleteUserConfirm(
                        userId: user.id,
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
