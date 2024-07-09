class HealthyCenter {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? cityName;
  String? directorateName;
  String? createAccountCode;
  String? officeName;
  int? directorateId;
  int? cityId;
  int? officeId;
  DateTime? createdAt;

  HealthyCenter({
    this.id,
    this.cityName,
    this.directorateName,
    this.officeName,
    this.createdAt,
    this.name,
    this.phone,
    this.address,
    this.cityId,
    this.directorateId,
    this.officeId,
    this.createAccountCode,
  });

  factory HealthyCenter.fromJson(Map<String, dynamic> json) {
    return HealthyCenter(
      id: json['id'] ?? 0,
      name: json['healthy_center_name'] ?? '',
      phone: json['healthy_center_phone'] ?? '',
      address: json['healthy_center_address'] ?? '',
      cityId: json['cities_id'] ?? 0,
      directorateId: json['directorate_id'] ?? 0,
      officeId: json['office_id'] ?? 0,
      cityName: json['city_name'] ?? '',
      directorateName: json['directorate_name'] ?? '',
      officeName: json['office_name'] ?? '',
      createAccountCode: json['create_account_code'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthy_center_name': name,
      'healthy_center_phone': phone,
      'healthy_center_address': address,
      'cities_id': cityId,
      'directorate_id': directorateId,
      'create_account_code': createAccountCode,
    };
  }
}
