class DosageWithVaccine {
  int? id;
  int? ChildDosageTypeId;
  String? ChildDosageType;


  DosageWithVaccine({
    this.id,
    required this.ChildDosageTypeId,
    this.ChildDosageType,
  });

  factory DosageWithVaccine.fromJson(Map<String, dynamic> json) {
    return DosageWithVaccine(
      id: json['id'],
      ChildDosageTypeId: json['child_dosage_type_id'] ?? 0,
      ChildDosageType: json['child_dosage_type'] ?? '',
    );
  }
}