class Office {
  int? id;
  String? name;
  String? phone;
  String? address;
  DateTime? createdAt;

  Office({
    this.id,
    this.createdAt,
    this.name,
    this.phone,
    this.address,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'] ?? 0,
      name: json['office_name'] ?? '',
      phone: json['office_phone'] ?? '',
      address: json['office_address'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }
}
