class City {
  int? id;
  String name;

  City({
    this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['city_name'],
    );
  }
}
