class DosageLevel {
  int? id;
  String dosage_level;

  DosageLevel({
    this.id,
    required this.dosage_level,
  });

  factory DosageLevel.fromJson(Map<String, dynamic> json) {
    return DosageLevel(
      id: json['id'],
      dosage_level: json['dosage_level'],
    );
  }
}
