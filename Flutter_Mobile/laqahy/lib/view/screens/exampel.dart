import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(color: MyColors.primaryColor)),
          child: DataTable2(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            border: TableBorder(
              // borderRadius: BorderRadius.circular(10),
              horizontalInside: BorderSide(
                color: MyColors.primaryColor,
              ),

              // left: BorderSide(color: MyColors.primaryColor),
              // right: BorderSide(color: MyColors.primaryColor),
              // bottom: BorderSide(color: MyColors.primaryColor),
            ),

            showBottomBorder: true,
            empty: ApiExceptionWidgets().myDataNotFound(
              onPressedRefresh: () {
                // uc.fetchUsers(uc.centerId);
              },
            ),
            headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
            columnSpacing: 5,
            horizontalMargin: 12,
            headingRowDecoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            dataRowColor: MaterialStateColor.transparent,
            // minWidth: 600,
            columns: [
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "الاسم",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "العمر",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "التاريخ",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
              ),
            ],

            rows: List<DataRow>.generate(
              10,
              (index) => DataRow(
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
                        'kkkkk',
                        // user.name ?? "غيـر معـروف",
                        textAlign: TextAlign.center,
                        style: MyTextStyles.font14BlackMedium,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'kkll',
                        // user.genderType,
                        textAlign: TextAlign.center,
                        style: MyTextStyles.font14BlackMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
