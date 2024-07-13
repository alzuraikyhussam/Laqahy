class ChildVaccineDosage {
  int? vaccineTypeId;
  String? vaccineType;
  int? totalDosageCount;
  int? childDosageCount;

  ChildVaccineDosage({
    this.vaccineTypeId,
    this.vaccineType,
    this.totalDosageCount,
    this.childDosageCount,
  });

  factory ChildVaccineDosage.fromJson(Map<String, dynamic> json) {
    return ChildVaccineDosage(
      vaccineTypeId: json['vaccine_type_id'],
      vaccineType: json['vaccine_type'],
      totalDosageCount: json['total_dosage_count'],
      childDosageCount: json['child_dosage_count'],
    );
  }
}
