class MotherVisitData {
  int? id;
  String? dosageType;
  String? fullUserName;
  String? healthCenter;
  dynamic dosageDate;
  dynamic returnDate;

  MotherVisitData({
    this.id,
    required this.dosageType,
    required this.fullUserName,
    required this.healthCenter,
    required this.dosageDate,
    required this.returnDate,
  });
}
