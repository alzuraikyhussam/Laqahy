class Donor {
  int? id;
  String name;

  Donor({
    this.id,
    required this.name,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      name: json['donor_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donor_name': name,
    };
  }
}
