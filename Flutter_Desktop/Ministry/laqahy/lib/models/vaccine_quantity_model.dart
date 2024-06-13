class VaccineQuantity {
  int? id;
  int? vaccineTypeId;
  int? quantity;
  String? vaccineType;

  VaccineQuantity({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.quantity,
  });

  factory VaccineQuantity.fromJson(Map<String, dynamic> json) {
    return VaccineQuantity(
      id: json['id'],
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
