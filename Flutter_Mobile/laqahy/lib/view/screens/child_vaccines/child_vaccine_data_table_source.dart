import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/child_vaccine_dosage_model.dart';

List<DataRow> getChildVaccineRowSource({
  required List<ChildVaccineDosage> myData,
  required int count,
}) {
  return List<DataRow>.generate(count, (index) {
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
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
              myData[index].vaccineType ?? "غيـر معـروف",
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              myData[index].totalDosageCount.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              myData[index].childDosageCount.toString(),
              textAlign: TextAlign.center,
              style: MyTextStyles.font14BlackMedium,
            ),
          ),
        ),
      ],
    );
  });
}
