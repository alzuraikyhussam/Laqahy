class Office {
  int id;
  String name;
  String phone;
  String address;

  Office({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'] ?? 0,
      name: json['office_name'] ?? '',
      phone: json['office_phone'] ?? '',
      address: json['office_address'] ?? '',
    );
  }
}
