class ChildVaccine {
  int? id;
  String? age;
  String? childName;
  String? motherName;
  String? birthplace;
  DateTime? birthDate;
  DateTime? returnDate;
  String? gender;

  ChildVaccine({
    this.id,
    this.childName,
    this.motherName,
    this.birthDate,
    this.birthplace,
    this.returnDate,
    this.gender,
    this.age,
  });

  factory ChildVaccine.fromJson(Map<String, dynamic> json) {
    return ChildVaccine(
      id: json['id'],
      age: json['child_age'] ?? '',
      childName: json['child_name'],
      motherName: json['mother_name'],
      birthDate: json['child_data_birthDate'] != null
          ? DateTime.parse(json['child_data_birthDate'])
          : DateTime(1970, 1, 1), // default value if null
      birthplace: json['child_birthplace'],
      gender: json['gender_type'],
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : DateTime(1970, 1, 1), // default value if null
    );
  }
}
