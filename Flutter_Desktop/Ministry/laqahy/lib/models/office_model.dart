class Office {
  int? id;
  String? name;
  String? createAccountCode;
  String? phone;
  String? address;
  int? centersCount;
  DateTime? createdAt;

  Office({
    this.id,
    this.centersCount,
    this.createAccountCode,
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
      createAccountCode: json['create_account_code'],
      centersCount: json['healthy_centers_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'office_phone': phone,
  //     'office_address': address,
  //   };
  // }
}
