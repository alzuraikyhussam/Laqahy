class VaccineStatement {
  int? id;
  int? donorId;
  String? donorName;
  DateTime? date;
  int? vaccineTypeId;
  int? quantity;
  String? vaccineType;

  VaccineStatement({
    this.id,
    this.vaccineTypeId,
    this.vaccineType,
    this.quantity,
    this.donorId,
    this.donorName,
    this.date,
  });

  factory VaccineStatement.fromJson(Map<String, dynamic> json) {
    return VaccineStatement(
      id: json['id'],
      vaccineTypeId: json['vaccine_type_id'] ?? 0,
      vaccineType: json['vaccine_type'] ?? '',
      quantity: json['quantity'] ?? 0,
      donorId: json['donor_id'] ?? 0,
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime(1970, 1, 1), // default value if null
      donorName: json['donor_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccine_type_id': vaccineTypeId,
      'quantity': quantity,
      'donor_id': donorId,
    };
  }
}
