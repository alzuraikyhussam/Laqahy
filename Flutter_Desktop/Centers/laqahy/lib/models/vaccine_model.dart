class Vaccine {
  int? id;
  String? vaccineType;

  Vaccine({
    this.id,
    this.vaccineType,
  });

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      id: json['id'],
      vaccineType: json['vaccine_type'] ?? '',
    );
  }
}
