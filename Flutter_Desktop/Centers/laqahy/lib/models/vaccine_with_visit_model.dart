class VaccineWithVisit {
  int? id;
  int? vaccineTypeId;
  String? vaccineType;


  VaccineWithVisit({
    this.id,
    required this.vaccineTypeId,
    this.vaccineType,
  });

  factory VaccineWithVisit.fromJson(Map<String, dynamic> json) {
    return VaccineWithVisit(
      id: json['id'],
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
    );
  }
}