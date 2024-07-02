class DosageType {
  int? id;
  String dosage_type;

  DosageType({
    this.id,
    required this.dosage_type,
  });

  factory DosageType.fromJson(Map<String, dynamic> json) {
    return DosageType(
      id: json['id'],
      dosage_type: json['dosage_type'],
    );
  }
}
