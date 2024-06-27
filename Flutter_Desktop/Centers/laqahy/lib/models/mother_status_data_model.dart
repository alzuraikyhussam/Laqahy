import 'package:intl/intl.dart';

class Mothers {
  int? id;
  String mother_name;
  String mother_phone;
  String mother_identity_num;
  String mother_village;
  DateTime mother_birthDate;
  String? cityName;
  String? directorateName;
  String? healthyCenterName;
  int cities_id;
  int directorate_id;
  int healthy_center_id;

  Mothers({
    required this.mother_name,
    required this.mother_phone,
    this.id,
    required this.mother_birthDate,
    this.healthyCenterName,
    this.cityName,
    required this.mother_village,

    this.directorateName,
    required this.mother_identity_num,
    required this.cities_id,
    required this.directorate_id,
    required this.healthy_center_id,
  });

  factory Mothers.fromJson(Map<String, dynamic> json) {
    return Mothers(
      id: json['id'],
      mother_name: json['mother_name'] ?? '',
      mother_phone: json['mother_phone'] ?? '',
      mother_village: json['mother_village'] ?? '',
      mother_birthDate: json['mother_birthDate'] != null
          ? DateTime.parse(json['mother_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      mother_identity_num: json['mother_identity_num'] ?? '',
      cityName: json['cityName'] ?? '',
      healthyCenterName: json['healthyCenterName'] ?? '',
      directorateName: json['directorateName'] ?? '',
      cities_id: json['cities_id'] ?? 0,
      directorate_id: json['directorate_id'] ?? 0,
      healthy_center_id: json['healthy_center_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mother_name': mother_name,
      'mother_phone': mother_phone,
      'mother_village': mother_village,
      'mother_birthDate': DateFormat('yyyy-MM-dd').format(mother_birthDate),
      'mother_identity_num': mother_identity_num,
      'cities_id': cities_id,
      'directorate_id': directorate_id,
      'healthy_center_id': healthy_center_id,
    };
  }
}
