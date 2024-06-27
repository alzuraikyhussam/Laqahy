class Vaccine {
  int? id;
  int? vaccineTypeId;
  int? quantity;
  String? vaccineType;

  Vaccine({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.quantity,
  });

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      id: json['id'],
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
