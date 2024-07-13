class ChildData {
  int? id;
  String? childName;

  ChildData({
    this.id,
    this.childName,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      id: json['id'],
      childName: json['child_data_name'],
    );
  }
}
