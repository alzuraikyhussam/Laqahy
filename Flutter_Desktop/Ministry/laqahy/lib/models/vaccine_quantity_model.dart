class VaccineQuantity {
  int? id;
  int? vaccineTypeId;
  int? quantity;
  String? vaccineType;
  String? donor;
  DateTime? date;

  VaccineQuantity({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.quantity,
    this.donor,
    this.date,
  });

  factory VaccineQuantity.fromJson(Map<String, dynamic> json) {
    return VaccineQuantity(
      id: json['id'],
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
      quantity: json['quantity'] ?? 0,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime(1970, 1, 1), // default value if null
      donor: json['donor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccine_type_id': vaccineTypeId,
      'quantity': quantity,
      'donor': donor,
    };
  }
}
