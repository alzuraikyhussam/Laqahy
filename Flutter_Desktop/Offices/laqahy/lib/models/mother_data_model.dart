class MotherData {
  int? id;
  int? childrenCount;
  String? name;
  String? phone;
  DateTime? birthDate;
  String? village;
  String? identityNum;
  String? cityName;
  String? directorateName;
  String? healthyCenterName;
  DateTime? createdAt;

  MotherData({
    this.cityName,
    this.createdAt,
    this.id,
    this.childrenCount,
    this.birthDate,
    this.directorateName,
    this.healthyCenterName,
    this.identityNum,
    this.name,
    this.village,
    this.phone,
  });

  factory MotherData.fromJson(Map<String, dynamic> json) {
    return MotherData(
      id: json['id'] ?? 0,
      childrenCount: json['children_count'],
      name: json['mother_name'] ?? '',
      phone: json['mother_phone'] ?? '',
      cityName: json['city_name'] ?? '',
      directorateName: json['directorate_name'] ?? '',
      healthyCenterName: json['healthy_center_name'] ?? '',
      identityNum: json['mother_identity_num'] ?? '',
      village: json['mother_village'] ?? '',
      birthDate: json['mother_birthDate'] != null
          ? DateTime.parse(json['mother_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }
}
