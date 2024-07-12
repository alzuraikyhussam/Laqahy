class ChildData {
  int? id;
  String? name;
  String? motherName;
  DateTime? birthDate;
  String? birthplace;
  String? gender;
  String? healthyCenterName;
  String? officeName;
  DateTime? createdAt;

  ChildData({
    this.createdAt,
    this.id,
    this.birthDate,
    this.name,
    this.birthplace,
    this.gender,
    this.motherName,
    this.healthyCenterName,
    this.officeName,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      id: json['id'] ?? 0,
      name: json['child_data_name'] ?? '',
      birthplace: json['child_data_birthplace'] ?? '',
      healthyCenterName: json['healthy_center_name'] ?? '',
      officeName: json['office_name'] ?? '',
      gender: json['genders_type'] ?? '',
      motherName: json['mother_name'] ?? '',
      birthDate: json['child_data_birthDate'] != null
          ? DateTime.parse(json['child_data_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }
}
