import 'package:intl/intl.dart';

class MotherStatement {
  int? id;
  int? mother_data_id;
  int? healthy_center_id;
  int? user_id;
  int? dosage_type_id;
  int? dosage_level_id;
  DateTime? date_taking_dose;
  DateTime? return_date;
  String? motherName;
  String? healthy_center;
  String? userName;
  String? dosage_level;
  String? dosage_type;


  MotherStatement({
    required this.mother_data_id,
    required this.healthy_center_id,
    required this.user_id,
    required this.dosage_level_id,
    required this.dosage_type_id,
    required this.date_taking_dose,
    required this.return_date,
    this.motherName,
    this.healthy_center,
    this.id,
    this.userName,
    this.dosage_level,
    this.dosage_type,
  });

  factory MotherStatement.fromJson(Map<String, dynamic> json) {
    return MotherStatement(
      id: json['id'],
      mother_data_id: json['mother_data_id'] ?? 0,
      healthy_center_id: json['healthy_center_id'] ?? 0,
      user_id: json['user_id'] ?? 0,
      dosage_level_id: json['dosage_level_id'] ?? 0,
      dosage_type_id: json['dosage_type_id'] ?? 0,
      date_taking_dose: json['date_taking_dose'] != null
          ? DateTime.parse(json['date_taking_dose'])
          : DateTime(1970, 1, 1), // default value if null
      return_date: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : DateTime(1970, 1, 1), // default value if null
      motherName: json['mother_name'] ?? '',
      healthy_center: json['healthy_center_name'] ?? '',
      userName: json['user_name'] ?? '',
      dosage_level: json['dosage_level'] ?? '',
      dosage_type: json['dosage_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
                'mother_data_id' : mother_data_id,
                'healthy_center_id' : healthy_center_id,
                'user_id' : user_id,
                'date_taking_dose' : DateFormat('yyyy-MM-dd').format(date_taking_dose!),
                'return_date' : DateFormat('yyyy-MM-dd').format(return_date!),
                'dosage_type_id' : dosage_type_id,
                'dosage_level_id' : dosage_level_id,
    };
  }
}
