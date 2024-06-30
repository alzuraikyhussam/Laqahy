import 'package:intl/intl.dart';

class Childs {
  int? id;
  String child_data_name;
  String child_data_birthplace;
  DateTime child_data_birthDate;
  String? motherName;
  String? genderType;
  int mother_data_id;
  int gender_id;


  Childs({
    required this.child_data_name,
    required this.child_data_birthplace,
    this.id,
    required this.child_data_birthDate,
    this.motherName,
    this.genderType,
    required this.mother_data_id,
    required this.gender_id,
  });

  factory Childs.fromJson(Map<String, dynamic> json) {
    return Childs(
      id: json['id'],
      child_data_name: json['child_data_name'] ?? '',
      child_data_birthplace: json['child_data_birthplace'] ?? '',
      child_data_birthDate: json['child_data_birthDate'] != null
          ? DateTime.parse(json['child_data_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      motherName: json['motherName'] ?? '',
      genderType: json['genderType'] ?? '',
      mother_data_id: json['mother_data_id'] ?? 0,
      gender_id: json['gender_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_data_name': child_data_name,
      'child_data_birthplace': child_data_birthplace,
      'child_data_birthDate': DateFormat('yyyy-MM-dd').format(child_data_birthDate),
      'mother_data_id': mother_data_id,
      'gender_id': gender_id,
    };
  }
}
