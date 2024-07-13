import 'package:intl/intl.dart';

class ChildrenStatement {
  int? id;
  int? childDataId;
  int? healthyCenterId;
  int? userId;
  int? visitTypeId;
  int? vaccineTypeId;
  int? childDosageTypeId;
  DateTime? dateTakingDose;
  DateTime? returnDate;
  String? childName;
  String? healthyCenterName;
  String? userName;
  String? visitType;
  String? vaccineType;
  String? childDosageType;

  ChildrenStatement({
    required this.childDataId,
    required this.healthyCenterId,
    required this.userId,
    required this.visitTypeId,
    required this.vaccineTypeId,
    required this.childDosageTypeId,
    required this.dateTakingDose,
    required this.returnDate,
    this.childName,
    this.healthyCenterName,
    this.id,
    this.userName,
    this.visitType,
    this.vaccineType,
    this.childDosageType,
  });

  factory ChildrenStatement.fromJson(Map<String, dynamic> json) {
    return ChildrenStatement(
      id: json['id'],
      childDataId: json['child_data_id'] ?? 0,
      healthyCenterId: json['healthy_center_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      visitTypeId: json['visit_type_id'] ?? 0,
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      childDosageTypeId: json['child_dosage_type_id'] ?? 0,
      dateTakingDose: json['date_taking_dose'] != null
          ? DateTime.parse(json['date_taking_dose'])
          : DateTime(1970, 1, 1), // default value if null
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : DateTime(1970, 1, 1), // default value if null
      childName: json['child_data_name'] ?? '',
      healthyCenterName: json['healthy_center_name'] ?? '',
      userName: json['user_name'] ?? '',
      visitType: json['visit_period'] ?? '',
      vaccineType: json['vaccine_type'] ?? '',
      childDosageType: json['child_dosage_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_data_id': childDataId,
      'healthy_center_id': healthyCenterId,
      'user_id': userId,
      'date_taking_dose': DateFormat('yyyy-MM-dd').format(dateTakingDose!),
      'return_date': DateFormat('yyyy-MM-dd').format(returnDate!),
      'visit_type_id': visitTypeId,
      'vaccine_type_id': vaccineTypeId,
      'child_dosage_type_id': childDosageTypeId,
    };
  }
}
