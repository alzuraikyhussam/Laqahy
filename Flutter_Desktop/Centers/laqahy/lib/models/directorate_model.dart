class Directorate {
  int? id;
  String name;

  Directorate({
    this.id,
    required this.name,
  });

  factory Directorate.fromJson(Map<String, dynamic> json) {
    return Directorate(
      id: json['id'],
      name: json['directorate_name'],
    );
  }
}
