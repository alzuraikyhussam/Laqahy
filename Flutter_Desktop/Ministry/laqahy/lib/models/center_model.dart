class HealthyCenter {
  int? id;
  String name;
  String phone;
  String address;
  int directorateId;
  int cityId;
  int officeId;

  HealthyCenter({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.cityId,
    required this.directorateId,
    required this.officeId,
  });

  factory HealthyCenter.fromJson(Map<String, dynamic> json) {
    return HealthyCenter(
      id: json['id'],
      name: json['healthy_center_name'],
      phone: json['healthy_center_phone'],
      address: json['healthy_center_address'],
      cityId: json['cities_id'],
      directorateId: json['directorate_id'],
      officeId: json['office_id'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'healthy_center_name': name,
  //     'healthy_center_phone': phone,
  //     'healthy_center_address': address,
  //     'cities_id': cityId,
  //     'directorate_id': directorateId,
  //   };
  // }
}
